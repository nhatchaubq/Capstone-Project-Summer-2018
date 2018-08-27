<template>
    <div class="row" style="margin: 0; padding: 0; height: 100% important" v-if="locations">
        <GmapMap 
            ref="googlemap"
            :center="{lat: 0, 
                        lng: 0}"
            :zoom="1"
            map-type-id="terrain"
            class="material-box material-shadow"
            style="width: 100%; height: 80vh; padding: 0; transition: all .25s ease-in-out;"
            :style="{width: selectedLocation ? '49%' : '100%'}"
            >
            <GmapMarker
                v-for="(location, index) in locations" :key="'mapViewMarker' + location.Id"
                :position="google && new google.maps.LatLng(location.Latitude, location.Longitude)"
                :clickable="true"
                @mouseover="hoverLocation = location"
                @mouseout="hoverLocation = null"
                @click="() => {
                    setSelectedLocation(location, index);
                }"
            >
                <GmapInfoWindow v-if="((hoverLocation && hoverLocation.Id == location.Id)
                                    || (selectedLocation && selectedLocation.Id == location.Id))"
                            :position="google && new google.maps.LatLng( hoverLocation ? hoverLocation.Latitude : selectedLocation.Latitude, 
                                        hoverLocation ? hoverLocation.Longitud : selectedLocation.Longitude)">
                {{ (hoverLocation && hoverLocation.Id == location.Id) ? hoverLocation.Name : selectedLocation.Name }}
                {{ (hoverLocation && hoverLocation.Id == location.Id) && !selectedLocation ? ' - ' + hoverLocation.Address : '' }}
                </GmapInfoWindow>
            </GmapMarker>
        </GmapMap>
        <div class="material-box material-shadow" v-show="selectedLocation && mapViewSelectedLocation" style="width: 49%; margin-left: 2%;">
            <div>
                <i v-on:click="selectedLocation = null" class="fa fa-times" style="cursor: pointer; color: var(--danger-color)"></i>
            </div>
            <div style="color: #424242">
                <div class="header" v-if="selectedLocation">
                    <div style="font-size: 1.5rem; font-weight: 500; margin-bottom: .5rem">{{ selectedLocation.Name }}</div>
                    <div style="font-size: 0.95rem">{{ selectedLocation.Address }}</div>
                </div>
                <div>
                    <div>
                        <span v-if="mapViewSelectedLocation && !mapViewSelectedLocation.Blocks">{{  'This location has no blocks yet.' }}
                            <a style="font-weight: 500" v-if="authUser.Role === 'Manager' && !mapViewSelectedLocation.Blocks"
                                v-on:click="$router.push(`/location/${selectedLocation.Id}/add_block_floor_tile`)">
                                <i class="fa fa-plus-circle"></i>
                                <span> Create new block</span>
                            </a>
                        </span>
                        <!-- display location blocks, floors, tiles - start -->
                        <div>
                            <!-- <div>
                                <canvas v-show="selectedLocation && selectedLocation.Image" ref="floorPlanCanvas"></canvas>
                            </div> -->

                            <div v-if="mapViewSelectedLocation" style="margin-top: 1rem">
                                <button :key="'block' + block.Id" v-for="(block, index) in mapViewSelectedLocation.Blocks"
                                    style="margin-right: .5rem;"
                                    :style="{background: currentBlockIndex == index ? '#424242' : '',
                                            color: currentBlockIndex == index ? 'white' : 'black', }"
                                    class="button"
                                    v-on:click="() => {
                                        currentFloorIndex = 0;
                                        currentTileIndex = -1;
                                        if (currentBlockIndex == index) {
                                            currentBlockIndex = -1;
                                        } else {
                                            currentBlockIndex = index;
                                            currentFloorIndex = mapViewSelectedLocation.Blocks[index].TotalFloor - 1;
                                        }
                                    }">
                                    Block {{ block.Name }}
                                </button>
                            </div>
                        </div>                        
                        <div style="margin-top: 1rem;" v-if="currentBlockIndex >= 0 && !mapViewSelectedLocation.Blocks[currentBlockIndex].Floors">
                            This block has no floors.
                        </div>
                        <div style="margin-top: 1rem; width: 100%" v-if="mapViewSelectedLocation && mapViewSelectedLocation.Blocks && currentBlockIndex >= 0">
                            <div>
                                <div style="display: grid; grid-template-columns: 25% 75%;">
                                    <!-- display floors -->
                                    <div style="width: 100% !important;">
                                        <div v-if="currentBlockIndex >= 0 && mapViewSelectedLocation.Blocks[currentBlockIndex].Floors">
                                            <div style="margin-bottom: 1rem;">Floor<span v-if="mapViewSelectedLocation.Blocks[currentBlockIndex].Floors">s</span></div>
                                            <div :key="'blockFloors' + index" v-for="(floor, index) in mapViewSelectedLocation.Blocks[currentBlockIndex].Floors" style="padding-bottom: .3rem">
                                                <!-- button to select a floor -->
                                                <button class="button material-shadow" 
                                                        :class="{'btn-primary': (index == mapViewSelectedLocation.Blocks[currentBlockIndex].Floors.length - mapViewSelectedLocation.Blocks[currentBlockIndex].TotalBasementFloor - 1),
                                                                'is-active-block': currentFloorIndex == index,
                                                                }" 
                                                        style="width: 4rem !important; margin: .1rem 0;" 
                                                        :style="((index == mapViewSelectedLocation.Blocks[currentBlockIndex].TotalFloor - 1) 
                                                                    && currentFloorIndex == index) ? 
                                                                    'background: var(--darken-primary-color) !important; border: none !important' : ''"
                                                        v-on:click="() => {
                                                            currentFloorIndex = index;
                                                            currentTileIndex = -1;
                                                        }">
                                                    {{ floor.Name }}
                                                </button> <!-- button to select a floor -->
                                            </div>                                            
                                        </div>
                                    </div><!-- display floors -->
                                    <!-- after selected a floor -->
                                    <div v-if="currentFloorIndex >= 0" style="width: 100% !important;">
                                        <div style="margin-bottom: 1rem; width: 100%">Tile<span v-if="mapViewSelectedLocation.Blocks[currentBlockIndex].Floors[currentFloorIndex].Tiles">s</span></div>
                                        <div style="margin-bottom: .5rem" :key="'tile' + index" v-for="(tile, index) in mapViewSelectedLocation.Blocks[currentBlockIndex].Floors[currentFloorIndex].Tiles">
                                            <a v-on:click="() => {
                                                currentTileIndex = index;
                                                showTileEquipment(tile.Id);
                                            }">Tile {{tile.Name}}</a>
                                        </div>
                                    </div> <!-- after selected a floor -->
                                </div>
                            </div>
                        </div>
                        <!-- display location blocks, floors, tiles - end -->
                    </div>
                </div>
            </div>
        </div>
        <!-- tile equipment popup -->
        <modal v-model="showTileEquipmentPopup">            
            <div slot="header">
                <span style="font-size: 1.3rem" v-if="currentBlockIndex >= 0 && currentFloorIndex >= 0 && currentTileIndex >= 0" >
                    Floor {{mapViewSelectedLocation.Blocks[currentBlockIndex].Floors[currentFloorIndex].Name }} - Tile {{ mapViewSelectedLocation.Blocks[currentBlockIndex].Floors[currentFloorIndex].Tiles[currentTileIndex].Name }}
                </span>
            </div>
            <div slot="footer">
                <button class="button btn-primary" style="width: 4rem;"  @click="showTileEquipmentPopup = false">OK</button>
            </div>
            <div :style="{
                'max-height': '50vh',
                'overflow-y': 'auto',
            }" v-if="currentBlockIndex >= 0 && currentFloorIndex >= 0 && currentTileIndex >= 0" >
                <v-flex v-if="tileEquipments.length > 0">
                    <v-expansion-panel expand>
                        <v-expansion-panel-content v-for="equipment in tileEquipments" :key="'equipment' + equipment.Id">
                            <div slot="header" style="display: grid; grid-template-columns: 25% auto;">
                                <div style="display: flex">
                                    <img v-show="equipment.Image" :src="equipment.Image" :alt="equipment.Name" style="width: 3rem; height: 3rem;">
                                </div>
                                <div style="display: grid; grid-template-rows: auto auto; font-size: 1rem">
                                    <div>
                                        {{ equipment.Name }}
                                    </div>                                            
                                    <div style="font-size: .9rem">
                                        Quantity: {{ equipment.EquipmentItems.length }} {{ equipment.Unit }}
                                    </div>
                                </div>
                            </div>
                            <v-card style="" v-for="item in equipment.EquipmentItems" :key="'item' + item.Id">
                                <v-card-text class="grey lighten-3" style="font-size: .9rem">
                                    Serial #: <a>{{ item.SerialNumber }}</a>
                                </v-card-text>
                            </v-card>
                        </v-expansion-panel-content>
                    </v-expansion-panel>
                </v-flex>
                <div v-else style="font-size: 1rem;">
                    There is no equipment in tile {{ mapViewSelectedLocation.Blocks[currentBlockIndex].Floors[currentFloorIndex].Tiles[currentTileIndex].Name }}.
                </div>
            </div>
      </modal>
    </div>    
</template>

<script>
import Server from '@/config/config';
import { gmapApi } from "vue2-google-maps";

export default {
    props: {
        locations: null,
    },
    async mounted() {
        if (this.locations) {
            this.bounds = new this.google.maps.LatLngBounds();
            for (let location of this.locations) {
                // alert(this.locations.length);
                this.bounds.extend(new this.google.maps.LatLng(location.Latitude, location.Longitude));
            }
            this.$refs.googlemap.$mapPromise.then((map) => {
                map.fitBounds(this.bounds);
            });
        } 
    },
    computed: {
        authUser() {
            return JSON.parse(window.localStorage.getItem('user'));
        },
        google: gmapApi,
    },
    data() {
        return {            
            // medianLatitude: null,
            // medianLongitude: null,
            // zoomfactor: 11,
            bounds: null,
            mapViewSelectedLocation: null,
            selectedLocation: null,
            selectedLocationIndex: -1,
            hoverLocation: null,
            currentBlockIndex: -1,
            currentFloorIndex: -1,
            currentTileIndex: -1,
            showTileEquipmentPopup: false,
            tileEquipments: [],
            imageCache: [],
        }
    },
    methods: {
        setSelectedLocation(location, index) {
            this.currentBlockIndex = -1;
            this.currentFloorIndex = -1;
            this.currentTileIndex = -1;
            this.tileEquipments = [];
            this.imageCache = [];
            if (this.selectedLocation && this.selectedLocation.Id == location.Id) {
                this.selectedLocation = null;                
            } else {
                this.selectedLocation = location;
                this.selectedLocationIndex = index;
            }
        },
        async showTileEquipment(tileId) {
            let url = `http://localhost:3000/api/tile/equipmentItems/${tileId}`;
            return await this.axios.get(url)
                .then(res => {
                    if (res.status == 200) {
                        this.tileEquipments = res.data;
                        this.showTileEquipmentPopup = true;
                    }
                }).catch(error => {
                    this.$router.push('/500');
                    console.log(error);
                })
        }
    },
    watch: {
        'selectedLocation': async function() {
            this.mapViewSelectedLocation = null;
            this.currentBlockIndex = -1;
            this.bounds = new this.google.maps.LatLngBounds();
            if (this.selectedLocation) {
                this.bounds.extend({lat: this.selectedLocation.Latitude - 0.0015, lng: this.selectedLocation.Longitude - 0.0015 });
                this.bounds.extend({lat: this.selectedLocation.Latitude, lng: this.selectedLocation.Longitude});
                this.bounds.extend({lat: this.selectedLocation.Latitude + 0.0015, lng: this.selectedLocation.Longitude + 0.0015 });
                let url = `${Server.LOCATION_BLOCK_FLOOR_TILE_API_PATH}/${this.selectedLocation.Id}`;
                await this.axios.get(url)
                    .then((res) => {
                        if (res.data) {
                            this.mapViewSelectedLocation = res.data;
                            if (this.mapViewSelectedLocation.Blocks) {
                                this.currentBlockIndex = 0;
                                this.currentFloorIndex = this.mapViewSelectedLocation.Blocks[this.currentBlockIndex].TotalFloor - 1;
                            }
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            } else {
                for (let location of this.locations) {
                    this.bounds.extend(new this.google.maps.LatLng(location.Latitude, location.Longitude));
                }
            }
            this.$refs.googlemap.$mapObject.fitBounds(this.bounds);
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

    .left-panel {
        position: fixed;
    }
</style>
