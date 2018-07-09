<template>
    <div class="row" style="margin: 0; padding: 0; height: 100% important" v-if="locations && medianLatitude && medianLongitude">
        <div class="material-box material-shadow" style="padding: 0; transition: all .25s ease-in-out" :style="{width: selectedLocation ? '49%' : '100%'}">
            <GmapMap          
                :center="google && new google.maps.LatLng(selectedLocation ? selectedLocation.Latitude : medianLatitude, 
                          selectedLocation ? selectedLocation.Longitude : medianLongitude)"
                :zoom="selectedLocation ? 16 : 13"
                map-type-id="terrain"
                style="width: 100%; height:80vh"
                >
            <GmapMarker
                v-for="location in locations" :key="'mapViewMarker' + location.Id"
                :position="google && new google.maps.LatLng(location.Latitude, location.Longitude)"
                :clickable="true"
                @mouseover="hoverLocation = location"
                @mouseout="hoverLocation = null"
                @click="() => {
                    setSelectedLocation(location);
                }"
            >
             <GmapInfoWindow v-if="((hoverLocation && hoverLocation.Id == location.Id)
                                    || (selectedLocation && selectedLocation.Id == location.Id))"
                            :position="google && new google.maps.LatLng( hoverLocation ? hoverLocation.Latitude : selectedLocation.Latitude, 
                                        hoverLocation ? hoverLocation.Longitud : selectedLocation.Longitude)">
                {{ (hoverLocation && hoverLocation.Id == location.Id) ? hoverLocation.Name : selectedLocation.Name }}
                  - 
                {{ (hoverLocation && hoverLocation.Id == location.Id) ? hoverLocation.Address : selectedLocation.Address }}
             </GmapInfoWindow>
            </GmapMarker>
            <!-- <gmap-info-window :key="'mapViewLocationInfoWindow' + location.Id" v-for="location in locations">{{ location.Name }}</gmap-info-window> -->
            </GmapMap>
        </div>
        <div class="material-box material-shadow" v-show="selectedLocation && mapViewSelectedLocation" style="width: 49%; margin-left: 2%;">
            <div>
                <i v-on:click="selectedLocation = null" class="fa fa-times" style="cursor: pointer; color: var(--danger-color)"></i>
                <a v-show="authUser.Role === 'Manager'" style="float: right; font-size: 0.95rem; font-weight: 500;">Edit</a>
            </div>
            <div style="color: #424242">
                <div class="header" v-if="selectedLocation">
                    <div style="font-size: 1.5rem; font-weight: 500; margin-bottom: .5rem">{{ selectedLocation.Name }}</div>
                    <div style="font-size: 0.95rem">{{ selectedLocation.Address }}</div>
                </div>
                <div class="content">
                    <div>
                        <span v-if="mapViewSelectedLocation && !mapViewSelectedLocation.Blocks">{{  'This location has no blocks yet. ' }}
                            <a style="font-weight: 500" v-if="authUser.Role === 'Manager' && !mapViewSelectedLocation.Blocks"
                                v-on:click="$router.push(`/location/${selectedLocation.Id}/add_block_floor_tile`)">
                                <i class="fa fa-plus-circle"></i>
                                <span> Create new block now</span>
                            </a>
                        </span>
                        <div>
                            <canvas v-show="selectedLocation && selectedLocation.Image" ref="floorPlanCanvas"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import Server from '@/config/config';
import { gmapApi } from "vue2-google-maps";

export default {
    props: {
        locations: null,
        medianLatitude: null,
        medianLongitude: null,
    },
    computed: {
        authUser() {
            return JSON.parse(window.localStorage.getItem('user'));
        },
        google: gmapApi,
    },
    data() {
        return {
            mapViewSelectedLocation: null,
            selectedLocation: null,
            hoverLocation: null,
        }
    },
    methods: {
        setSelectedLocation(location) {
            if (this.selectedLocation && this.selectedLocation.Id == location.Id) {
                this.selectedLocation = null;
            } else {
                this.selectedLocation = location;
                if (location.Image) {
                    let canvas = this.$refs.floorPlanCanvas;
                    let canvasContext = canvas.getContext('2d');
                    let background = new Image();
                    background.src = location.Image;
                    background.onload = () => {
                        canvas.width = background.width;
                        canvas.height = background.height;
                        canvasContext.drawImage(background, 0, 0);
                    };        
                }
            }
        }
    },
    watch: {
        'selectedLocation': function() {
            this.mapViewSelectedLocation = null;
            if (this.selectedLocation) {
                let url = `${Server.LOCATION_BLOCK_FLOOR_TILE_API_PATH}/${this.selectedLocation.Id}`;
                this.axios.get(url)
                    .then((res) => {
                        if (res.data) {
                            this.mapViewSelectedLocation = res.data;
                            if (this.selectedLocation.Image) {
                                let canvas = this.$refs.floorPlanCanvas;
                                let canvasContext = canvas.getContext('2d');
                                let background = new Image();
                                background.src = this.selectedLocation.Image;
                                background.onload = () => {
                                    // canvas.width = background.width;
                                    // canvas.height = background.height;
                                    canvasContext.drawImage(background, 0, 0);
                                };        
                            }
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            }
        }
    }
}
</script>

<style scoped>
    .content {
        font-size: 0.95rem;
    }
    
    .header {
        margin-bottom: 1rem;
    }

    .content > div {
        margin-bottom: 1rem;
    }
</style>
