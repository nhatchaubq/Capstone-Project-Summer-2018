<template>
    <div class="row" style="margin: 0; padding: 0; height: 100% important" v-if="locations && medianLatitude && medianLongitude">
        <GmapMap          
            :center="google && new google.maps.LatLng(selectedLocation ? selectedLocation.Latitude : medianLatitude, 
                        selectedLocation ? selectedLocation.Longitude : medianLongitude)"
            :zoom="selectedLocation ? 16 : 13"
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
                    - 
                {{ (hoverLocation && hoverLocation.Id == location.Id) ? hoverLocation.Address : selectedLocation.Address }}
                </GmapInfoWindow>
            </GmapMarker>
        </GmapMap>
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
                        <!-- display location blocks, floors, tiles - start -->
                        <div>
                            <div>
                                <canvas v-show="selectedLocation && selectedLocation.Image" ref="floorPlanCanvas"></canvas>
                            </div>

                            <div v-if="mapViewSelectedLocation" style="margin-top: 1rem">
                                <button :key="'block' + block.Id" v-for="(block, index) in mapViewSelectedLocation.Blocks"
                                    style="margin: right: 2rem;"
                                    :style="{background: curentBlockIndex == index ? '#424242' : '',
                                            color: curentBlockIndex == index ? 'white' : 'black', }"
                                    class="button"
                                    v-on:click="() => {
                                        if (curentBlockIndex == index) {
                                            curentBlockIndex = -1;
                                        } else {
                                            curentBlockIndex = index;
                                        }
                                    }">
                                    Block {{ block.Name }}
                                </button>
                            </div>
                        </div>
                        <div style="margin-top: 1rem" v-if="mapViewSelectedLocation && mapViewSelectedLocation.Blocks && curentBlockIndex >= 0">
                            <div>
                                <div class="row" style="margin: .5rem 0 !important">
                                    <!-- display floors -->
                                    <div style="width: 15%;">
                                        <div style="margin-bottom: 1rem;">Floors</div>
                                        <div :key="'blockFloors' + index" v-for="(floor, index) in mapViewSelectedLocation.Blocks[curentBlockIndex].Floors" style="padding-bottom: .3rem">
                                            <!-- button to select a floor -->
                                            <button class="button material-shadow" 
                                                    :class="{'btn-primary': (index == mapViewSelectedLocation.Blocks[curentBlockIndex].TotalFloor - mapViewSelectedLocation.Blocks[curentBlockIndex].TotalBasementFloor - 1),
                                                            'is-active-block': currentFloorIndex == index,
                                                            }" 
                                                    style="text-align: center; width: 100%;" 
                                                    :style="((index == mapViewSelectedLocation.Blocks[curentBlockIndex].TotalFloor - mapViewSelectedLocation.Blocks[curentBlockIndex].TotalBasementFloor - 1) 
                                                                && currentFloorIndex == index) ? 
                                                                'background: var(--darken-primary-color) !important; border: none !important' : ''"
                                                    v-on:click="() => {
                                                        currentFloorIndex = index;
                                                        currentTileIndex = -1;
                                                    }">
                                                {{ floor.Name }}
                                            </button> <!-- button to select a floor -->
                                        </div>
                                    </div><!-- display floors -->
                                    <!-- after selected a floor -->
                                    <div v-if="currentFloorIndex >= 0" style="width: 75%; margin-left: 10%; padding: 0 !important;">
                                        <div style="margin-bottom: 1rem;">Tiles (rooms)</div>
                                        <div :key="'tile' + index" v-for="(tile, index) in mapViewSelectedLocation.Blocks[curentBlockIndex].Floors[currentFloorIndex].Tiles">
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
                <span style="font-size: 1.3rem" v-if="curentBlockIndex >= 0 && currentFloorIndex >= 0 && currentTileIndex >= 0" >
                    Tile {{ mapViewSelectedLocation.Blocks[curentBlockIndex].Floors[currentFloorIndex].Tiles[currentTileIndex].Name }}
                </span>
            </div>
            <div slot="footer">
                <Button size="large" long class="button btn-primary" @click="showTileEquipmentPopup = false">OK</Button>
            </div>
            <div :style="{
                'max-height': '50vh',
                'overflow-y': 'auto',
            }" v-if="curentBlockIndex >= 0 && currentFloorIndex >= 0 && currentTileIndex >= 0" >
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
                    There is no equipments in tile {{ mapViewSelectedLocation.Blocks[curentBlockIndex].Floors[currentFloorIndex].Tiles[currentTileIndex].Name }}.
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
        medianLatitude: null,
        medianLongitude: null,
    },
    mounted() {
        if (this.locations) {
            for(var i = 0; i < this.locations.length; i++) {
                let cache = {
                    background: null,
                }
                this.imageCache.push(cache);
            }
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
            mapViewSelectedLocation: null,
            selectedLocation: null,
            selectedLocationIndex: -1,
            hoverLocation: null,
            curentBlockIndex: -1,
            currentFloorIndex: -1,
            currentTileIndex: -1,
            showTileEquipmentPopup: false,
            tileEquipments: [],
            imageCache: [],
        }
    },
    methods: {
        setSelectedLocation(location, index) {
            this.curentBlockIndex = -1;
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
        showTileEquipment(tileId) {
            let url = `http://localhost:3000/api/tile/equipmentItems/${tileId}`;
            this.axios.get(url)
                .then(res => {
                    if (res.status == 200) {
                        this.tileEquipments = res.data;
                        this.showTileEquipmentPopup = true;
                    }
                }).catch(error => {
                    console.log(error);
                }) 
        }
    },
    watch: {
        'selectedLocation': function() {
            this.mapViewSelectedLocation = null;
            this.curentBlockIndex = -1;
            if (this.selectedLocation) {
                let url = `${Server.LOCATION_BLOCK_FLOOR_TILE_API_PATH}/${this.selectedLocation.Id}`;
                this.axios.get(url)
                    .then((res) => {
                        if (res.data) {
                            this.mapViewSelectedLocation = res.data;
                            if (this.selectedLocation.Image) {
                                let canvas = this.$refs.floorPlanCanvas;
                                var background = null;
                                if (this.imageCache[this.selectedLocationIndex].background) {
                                    background = this.imageCache[this.selectedLocationIndex].background;
                                } else {
                                    background = new Image()
                                    background.src = this.selectedLocation.Image;
                                }
                                let MAX_WIDTH = 460;
                                let MAX_HEIGHT = 460;
                                var width = background.width;
                                var height = background.height;

                                if (width > height) {
                                    if (width > MAX_WIDTH) {
                                        height *= MAX_WIDTH / width;
                                        width = MAX_WIDTH;
                                    }
                                } else {
                                    if (height > MAX_HEIGHT) {
                                        width *= MAX_HEIGHT / height;
                                        height = MAX_HEIGHT;
                                    }
                                }
                                canvas.width = width;
                                canvas.height = height;
                                let canvasContext = canvas.getContext('2d');
                                if (this.imageCache[this.selectedLocationIndex].background) {
                                    canvasContext.drawImage(background, 0, 0, width, height);
                                } else {
                                    background.onload = () => {
                                        canvasContext.drawImage(background, 0, 0, width, height);
                                        this.imageCache[this.selectedLocationIndex].background = background;
                                    }
                                }    
                            }
                            this.curentBlockIndex = 0;
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

    .left-panel {
        position: fixed;

    }
</style>
