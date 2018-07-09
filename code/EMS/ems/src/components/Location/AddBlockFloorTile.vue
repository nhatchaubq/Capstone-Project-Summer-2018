<template>
    <div v-if="location" style="padding: 0 !important">
        <div style="padding: 1rem 2rem 0rem 2rem">
            <router-link :to="{path: '/location', meta: {viewMode: 'MapView'}, params: {locationId: location.Id}}">
                <a><span class="fa fa-chevron-left"></span> Back to Map View</a>
            </router-link>
        </div>
        <div class="form">
            <div class="form-title">
                <h1 style="font-weight: bold; font-size: 1.5rem">{{ location.Name }}</h1>
                <h2 style="font-size: 1rem; margin-top: .5rem">{{ location.Address }}</h2>
            </div>
            <div class="form-content">
                <div v-if="currentStep === Steps.ASK_LOCATION_FLOOR_PLAN_IMAGE">
                    <div class="form-field">
                        <div class="form-field-title">
                            Do you have a floor plan image for location {{ location.Name }}?                            
                        </div>          
                        <div class="form-field-input">
                            <label class="radio" v-on:click="() => {haveLocationFloorPlanImage = true}">
                                <input type="radio" name="haveLocationFloorPlanImage" :checked="haveLocationFloorPlanImage">
                                Yes
                            </label>
                            <label class="radio" v-on:click="() => {haveLocationFloorPlanImage = false}">
                                <input type="radio" name="haveLocationFloorPlanImage" :checked="!haveLocationFloorPlanImage">
                                No
                            </label>
                        </div>
                    </div>
                    <div class="form-field">
                        <div class="form-field-nav">
                            <a style="float: left !important" v-on:click="() => {
                                if (haveLocationFloorPlanImage) {
                                    currentStep = Steps.CREATE_BLOCK_FLOOR_PLAN_IMAGE_FOR_LOCATION;
                                } else {
                                    currentStep = Steps.CREATE_BLOCK_FOR_LOCATION;
                                }
                            }">Next <i class="fa fa-chevron-circle-right"></i></a>    
                        </div>
                    </div>
                </div>
                <div v-if="currentStep === Steps.CREATE_BLOCK_FLOOR_PLAN_IMAGE_FOR_LOCATION">
                    <div class="form-field">
                        <div class="form-field-title">
                            Upload floor plan image of location {{ location.Name }}
                        </div>
                        <div class="form-field-input" style="display: flex !important">
                            <file-base64 :done="getFile"></file-base64>
                        </div>
                    </div>
                </div>
                <div v-show="currentStep === Steps.CREATE_BLOCK_FLOOR_PLAN_IMAGE_FOR_LOCATION || currentStep === Steps.CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS">
                    <div class="form-field" v-show="locationFloorPlanImage">
                        <canvas :style="currentStep === Steps.CREATE_BLOCK_FLOOR_PLAN_IMAGE_FOR_LOCATION ? 
                                                            'cursor: pointer' : (currentStep === Steps.CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS ?
                                                                                'cursor: not-allowed' : '')" ref="locationCanvas"></canvas> 
                    </div>
                </div>
                <div v-if="currentStep === Steps.CREATE_BLOCK_FLOOR_PLAN_IMAGE_FOR_LOCATION">
                    <div class="form-field" v-if="locationFloorPlanImage && !newBlock && (currentLocationPaintToolMode == paintToolMode.Preset && newLocation && newLocation.blocks.length == 0)">
                            <a v-on:click="() => {
                                newBlock = {name: '', points: [], floors: []};
                            }"><i class="fa fa-plus-circle"></i> Add new block</a>
                        </div>
                    <div v-if="locationFloorPlanImage && newBlock">
                        <!-- paint helper tool -->
                        <div class="form-field">
                            <div>
                                Paint helper tool:
                                <label class="radio" v-on:click="currentLocationPaintToolMode = paintToolMode.Preset">
                                    <input name="paintToolMode" :checked="currentLocationPaintToolMode == paintToolMode.Preset" type="radio">
                                    Preset
                                </label>
                                <label class="radio" v-on:click="currentLocationPaintToolMode = paintToolMode.Rectangle">
                                    <input name="paintToolMode" :checked="currentLocationPaintToolMode == paintToolMode.Rectangle" type="radio">
                                    Rectangle tool
                                </label>
                                <label class="radio" v-on:click="currentLocationPaintToolMode = paintToolMode.Hand">
                                    <input name="paintToolMode" :checked="currentLocationPaintToolMode == paintToolMode.Hand" type="radio">
                                    By hand
                                </label>
                            </div>
                            <!-- select grid preset -->
                            <div class="field is-horizontal">
                                <div class="select" v-if="currentLocationPaintToolMode == paintToolMode.Preset">
                                    <select v-model="locationSelectedGridPresetOption">
                                        <option value="null" disabled selected="true">Select a preset</option>
                                        <option :value="{column: 1, row: 1}">1 x 1</option>
                                        <option :value="{column: 1, row: 2}">1 x 2</option>
                                        <option :value="{column: 2, row: 1}">2 x 1</option>
                                        <option :value="{column: 2, row: 2}">2 x 2</option>
                                        <option :value="{column: 3, row: 1}">3 x 1</option>
                                        <option :value="{column: 3, row: 2}">3 x 2</option>
                                        <option :value="{column: 3, row: 3}">3 x 3</option>
                                        <option :value="{column: 5, row: 2}">5 x 2</option>
                                        <option :value="{column: 5, row: 3}">5 x 3</option>
                                        <option :value="{column: 6, row: 2}">6 x 2</option>
                                        <option :value="{column: 6, row: 3}">6 x 3</option>
                                        <option value="custom">Custom</option>
                                    </select>
                                </div>
                                <div v-if="locationSelectedGridPresetOption == 'custom'">
                                    <span style="position: relative; top: .5rem; margin-left: 1rem; align-text: right;">Column: </span>
                                    <span><input style="width: 4rem; text-align: right;" class="input" type="number" min="1" v-model="locationGridCustomColumns"> </span>
                                    <span style="position: relative; top: .5rem; margin-left: 1rem;"> Row: </span>
                                    <span><input style="width: 4rem; text-align: right;" class="input" type="number" min="1" v-model="locationGridCustomRows"> </span>
                                </div>                            
                            </div> <!-- select grid preset -->
                            <div>
                                <div v-if="currentLocationPaintToolMode == paintToolMode.Hand">
                                    <button class="button" :disabled="newBlock.points.length == 0" v-on:click="() => {
                                        newBlock.points.pop(); 
                                        if(newBlock.points.length > 0) {
                                            drawPoints($refs.locationCanvas);
                                        } else {
                                            clearCanvas();
                                        }
                                    }">Undo</button>
                                    <button class="button" :disabled="locationSelectingPointIndex== -1" v-on:click="() => {
                                        newBlock.points.splice(locationSelectingPointIndex, 1); 
                                        if(newBlock.points.length > 0) {
                                            drawPoints($refs.locationCanvas);
                                        } else {
                                            clearCanvas();
                                        }
                                        locationSelectingPointIndex= -1;
                                    }">Remove</button>
                                    <button class="button" :disabled="newBlock.points.length == 0 || (newLocation && newLocation.blocks.length == 0)" v-on:click="() => {
                                        newBlock = {name: '', points: [], floor: []};    
                                        newLocation.blocks = [];
                                        locationSelectingPointIndex= -1;
                                        clearCanvas();
                                    }">Remove All</button>
                                    <div>
                                        <div class="field is-horizontal">
                                            <label>Tile name: </label>
                                            <input type="text" class="input" v-model="newBlock.name">
                                        </div>
                                        <button class="button" :disabled="newBlock.points.length < 2" v-on:click="() => {
                                           // polyList.push(newBlock);
                                            //newBlock = {name: '', points: []};
                                            //locationSelectingPointIndex= -1;
                                            //drawPoints();
                                        }">Save tile</button>
                                        <div>
                                            <button class="button" v-on:click="() => {                            
                                                showAlert(JSON.stringify(polyList));
                                            }">Finish</button>
                                        </div>
                                    </div>
                                </div>
                            </div>    
                        </div> <!-- paint helper tool -->
                        <!-- naming and describe block -->
                        <div v-if="newBlock">
                            <div class="form-field">
                                <div class="form-field-title">
                                    Notice: - Please use paint helper tool to select a block from your floor plan image. <br/>
                                    <span style="color: transparent;">Notice: </span>- For hand tool, you must draw at least 3 points to be accepted as a legal block.
                                </div>
                            </div>
                            <div v-if="currentLocationPaintToolMode == paintToolMode.Preset && locationSelectedTileIndex >= 0">
                                <div class="form-field">
                                    <div class="form-field-title">
                                        Name of this block
                                    </div>
                                    <div class="form-field-input" style="display: flex !important">
                                        <input :disabled="newBlock.points.length < 3" v-model="newBlock.name" type="text" class="input" required placeholder="A, B, C">
                                    </div>
                                </div>
                                <div class="form-field">
                                    <div class="form-field-title">
                                        Describe this block (optional)
                                    </div>
                                    <div class="form-field-input">
                                        <textarea :disabled="newBlock.points.length < 3" class="input" rows="5"></textarea>
                                    </div>
                                </div>
                                <div class="form-field">
                                    <a v-on:click="() => {
                                        if (currentLocationPaintToolMode == paintToolMode.Preset) {
                                            locationSelectedTileIndex = -1;
                                            newBlock = {name: '', points: [], floors: []};
                                        }
                                        // newBlock = null;
                                    }"><i class="fa fa-check-circle"></i> {{ currentLocationPaintToolMode == paintToolMode.Preset ? 'Save changes' : 'Create block' }}</a>
                                </div>
                            </div>
                        </div> <!-- naming and describe block -->
                    </div>
                    <!-- back, next button -->
                    <div class="form-field">
                        <div class="form-field-nav">
                            <!-- back button -->
                            <a v-on:click="() => {
                                currentStep = Steps.ASK_LOCATION_FLOOR_PLAN_IMAGE;
                                locationFloorPlanImage = null;
                                newLocation.blocks = [];
                                newBlock = null;
                            }"><i class="fa fa-chevron-circle-left"></i> Back</a>
                            <!-- next button -->
                            <!-- disable when no block created, so need to create at least a block to enable -->
                            <a :style="newLocation && newLocation.blocks.length == 0 ? 'color: var(--shadow) !important; cursor: not-allowed': ''" v-on:click="() => {
                                if (newLocation.blocks.length > 0) {
                                    totalFloor = 1;
                                    totalBasementFloor = 0;
                                    locationSelectedTileIndex = createFloorCurrentBlock;
                                    currentStep = Steps.CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS;
                                    paintCanvas($refs.locationCanvas, null, null);
                                }          
                            }">Next <i class="fa fa-chevron-circle-right"></i></a>    
                        </div>
                    </div> <!-- back, next button -->
                </div>
                <!-- this step is to create floors info of blocks -->
                <div v-if="currentStep === Steps.CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS" style="width: 100%">
                    <!-- currently, there is a block is selecting to create/edit floors info -->
                    <div v-if="createFloorCurrentBlock >= 0" class="row" style="padding: 0 !important;">
                        <!-- define floor info -->
                        <div class="col-6">
                            <div class="form-field">
                                <!-- creating block floor -->
                                <div class="form-field-title" v-if="!editingBlockFloor">
                                    Please provide some information that help create floors for Block {{ newLocation.blocks[createFloorCurrentBlock].name }}.                        
                                </div>
                                <!-- editing block floor -->
                                <div class="form-field-title" v-else>
                                    Editing floors information for Block {{ newLocation.blocks[createFloorCurrentBlock].name }}.                        
                                </div>
                            </div>
                            <div class="form-field">
                                <div class="form-field-title">
                                    <span style="position: relative; top: .5rem">Block {{ newLocation.blocks[createFloorCurrentBlock].name }} has </span>
                                    <span>
                                        <!-- creating block floor -->
                                        <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="1" v-model="totalFloor" v-if="!editingBlockFloor">
                                        <!-- editing block floor -->
                                        <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="1" v-model="newLocation.blocks[createFloorCurrentBlock].totalFloor" v-else>
                                    </span>
                                    <span style="position: relative; top: .5rem">floor<span v-if="totalFloor > 1">s</span>,</span>
                                    <span style="position: relative; top: .5rem"> and has </span>
                                    <span>
                                        <!-- creating block floor -->
                                        <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="0" v-model="totalBasementFloor" v-if="!editingBlockFloor">
                                        <!-- editing block floor -->
                                        <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="0" v-model="newLocation.blocks[createFloorCurrentBlock].totalBasementFloor" v-else>
                                    </span>
                                    <span style="position: relative; top: .5rem"> basement floor<span v-if="totalBasementFloor > 1">s</span>.</span>
                                </div>
                            </div>
                            <div class="form-field">
                                <div class="form-field-title">
                                    What would you call the first floor of Block {{ newLocation.blocks[createFloorCurrentBlock].name }} ?  
                                </div>
                                <!-- creating block floor -->
                                <div class="form-field-input" v-if="!editingBlockFloor">
                                    <label class="radio" v-on:click="() => {selectedFirstFloorType = FirstFloorType.Ground}">
                                        <input type="radio" name="firstFloorType" :checked="selectedFirstFloorType == FirstFloorType.Ground">
                                        Ground
                                    </label>
                                    <label class="radio" v-on:click="() => {selectedFirstFloorType = FirstFloorType.FloorOne}">
                                        <input type="radio" name="firstFloorType" :checked="selectedFirstFloorType == FirstFloorType.FloorOne">
                                        Floor 1
                                    </label>
                                </div>
                                <!-- editing block floor -->
                                <div class="form-field-input" v-else>
                                    <label class="radio" v-on:click="() => {newLocation.blocks[createFloorCurrentBlock].firstFloorType = FirstFloorType.Ground}">
                                        <input type="radio" name="firstFloorType" :checked="newLocation.blocks[createFloorCurrentBlock].firstFloorType == FirstFloorType.Ground">
                                        Ground
                                    </label>
                                    <label class="radio" v-on:click="() => {newLocation.blocks[createFloorCurrentBlock].firstFloorType = FirstFloorType.FloorOne}">
                                        <input type="radio" name="firstFloorType" :checked="newLocation.blocks[createFloorCurrentBlock].firstFloorType == FirstFloorType.FloorOne">
                                        Floor 1
                                    </label>
                                </div>
                            </div>
                            <!-- define tile name style -->
                            <div class="form-field">
                                <div class="form-field-title">
                                    Define your room name style (leave blank if you do not want to use custom name)
                                </div>
                                <div style="margin: .5rem 0 !important" class="row form-field-input">
                                    Prefix:
                                    <label class="radio">
                                        <input :checked="tilePrefix == 'none'" v-on:click="tilePrefix = 'none'" class="radio" type="radio">
                                        None
                                    </label>
                                    <label class="radio">
                                        <input :checked="tilePrefix == 'floororder'" v-on:click="tilePrefix = 'floororder'" class="radio" type="radio">
                                        Floor number
                                    </label>
                                    <label class="radio">
                                        <input :checked="tilePrefix == 'custom'" v-on:click="tilePrefix = 'custom'" class="radio" type="radio">
                                        Custom
                                    </label>
                                    <input style="margin-left: .5rem" v-if="tilePrefix == 'custom'" v-model="tilePrefixCustom" class="input" type="text" placeholder="A, B, C">
                                </div>
                            </div> <!-- define tile name style -->
                            
                            <div class="form-field">
                                <!-- click this <a> to create/edit floors info of a block -->
                                <a v-on:click="() => {
                                    if (!editingBlockFloor) {
                                        newLocation.blocks[createFloorCurrentBlock].totalFloor = totalFloor;
                                        newLocation.blocks[createFloorCurrentBlock].totalBasementFloor = totalBasementFloor;
                                        newLocation.blocks[createFloorCurrentBlock].firstFloorType = selectedFirstFloorType;
                                        // resetting values - start
                                        totalFloor = 1;
                                        totalBasementFloor = 0;
                                        selectedFirstFloorType = FirstFloorType.Ground;
                                        // resetting values - end
                                        ++createFloorCurrentBlock;
                                        locationSelectedTileIndex = createFloorCurrentBlock;
                                        // at the end of block list, no need move to next block to create more floor
                                        if (createFloorCurrentBlock >= newLocation.blocks.length) {
                                            createFloorCurrentBlock = -1; // createFloorCurrentBlock = -1 to display the review
                                            locationSelectedTileIndex = -1; // no more block hightlight on the canvas
                                        }
                                        // repaint the canvas the display the next block to create floors info
                                        paintCanvas(null, null);
                                    } else {
                                        createFloorCurrentBlock = -1;
                                        editingBlockFloor = false;
                                    }
                                }"><i class="fa fa-check-circle"></i> {{ editingBlockFloor ? 'Save changes ' : 'Finish creating floors for '}} Block {{ newLocation.blocks[createFloorCurrentBlock].name }}</a>
                            </div>
                        </div> <!-- define floor info -->
                        <!-- display floors visually -->
                        <div class="col-6">
                            <div class="form-field">
                                <div class="form-field-title" style="margin: .5rem 0 !important">
                                    Please click on visual floors below to setup rooms for each floor.
                                </div>
                                <div class="row" style="margin: .5rem 0 !important">
                                    <!-- display floors -->
                                    <div style="width: 15%;">
                                        <div :key="'blockFloors' + index" v-for="(floor, index) in newLocation.blocks[createFloorCurrentBlock].floors" style="padding-bottom: .3rem">
                                            <!-- button to select a floor -->
                                            <button class="button material-shadow" 
                                                    :class="{'btn-primary': (index == newLocation.blocks[createFloorCurrentBlock].floors.length - totalBasementFloor - 1),
                                                            'is-active-block': currentFloorIndex == index,
                                                            }" 
                                                    style="text-align: center; width: 100%;" 
                                                    :style="((index == newLocation.blocks[createFloorCurrentBlock].floors.length - totalBasementFloor - 1) 
                                                                && currentFloorIndex == index) ? 
                                                                'background: var(--darken-primary-color) !important; border: none !important' : ''"
                                                    v-on:click="() => {
                                                        currentFloorIndex = index;
                                                        currentTileIndex = -1;
                                                        if (newLocation.blocks[createFloorCurrentBlock].floors[currentFloorIndex].tiles.length == 0) {
                                                            totalTiles = 1;
                                                            makeTiles();
                                                        } else {
                                                            totalTiles = newLocation.blocks[createFloorCurrentBlock].floors[currentFloorIndex].tiles.length;
                                                        }
                                                        //let floor = newLocation.blocks[createFloorCurrentBlock].floors[currentFloorIndex];

                                                    }">
                                                {{ floor.name }}
                                            </button> <!-- button to select a floor -->
                                        </div>
                                    </div><!-- display floors -->
                                    <!-- after selected a floor -->
                                    <div v-if="currentFloorIndex >= 0" style="width: 75%; margin-left: 5%; padding: 0 !important;">
                                        <div style="margin: 0 !important;" class="row">
                                            <span style="position: relative; top: .5rem">Floor {{ newLocation.blocks[createFloorCurrentBlock].floors[currentFloorIndex].name }} has:</span>
                                            <input style="margin: 0 .5rem; text-align: right;" class="input col-2" type="number" min='1' v-model="totalTiles">
                                            <span style="position: relative; top: .5rem"> room<span v-if="totalTiles > 1">s</span></span>
                                        </div>
                                        <div v-if="newLocation.blocks[createFloorCurrentBlock].floors[currentFloorIndex].tiles.length > 0">
                                            <span><strong>Click on the rooms below to edit its name.</strong></span>
                                        </div>
                                        <div :key="'tile' + index" v-for="(tile, index) in newLocation.blocks[createFloorCurrentBlock].floors[currentFloorIndex].tiles">
                                            <a v-if="index != currentTileIndex" v-on:click="() => {
                                                if (currentTileIndex == index) {
                                                    currentTileIndex = -1;
                                                } else {
                                                    currentTileIndex = index;
                                                }
                                            }">Tile {{tile.name}}</a>
                                            <input v-if="index == currentTileIndex" class="input" type="text" v-model="newLocation.blocks[createFloorCurrentBlock].floors[currentFloorIndex].tiles[index].name">
                                            <a v-if="index == currentTileIndex" v-on:click="currentTileIndex = -1;">
                                                <i class="fa fa-check-circle"></i>
                                                Save changes
                                            </a>
                                        </div>
                                    </div> <!-- after selected a floor -->
                                </div>
                            </div>
                        </div> <!-- display floors visually -->
                    </div>
                    <!-- else, this happens after created floors for all the newLocation.blocks or save changes of an editing block -->
                    <div v-else>
                        <div class="form-field">
                            <div class="form-field-title">
                                Please recheck the floors information of <span v-if="newLocation.blocks.length == 1">this block</span><span v-if="newLocation.blocks.length > 1">these newLocation.blocks</span> (click on a block to edit floor information):
                            </div>
                            <div :key="'makeBlockFloor' + block.id" v-for="block in newLocation.blocks">
                                <div style="padding-left: 1rem; margin-bottom: .5rem">
                                    <!-- click the <a> below to edit selected block -->
                                    <span>- <a v-on:click="() => {
                                                createFloorCurrentBlock = block.id;
                                                locationSelectedTileIndex = block.id;
                                                editingBlockFloor = true;
                                                paintCanvas(null, null);
                                            }">Block {{ block.name }}</a> has <strong>{{ block.totalFloor }} floor<span v-if="block.totalFloor > 1">s</span></strong>
                                                    , <strong>{{ block.totalBasementFloor > 0 ? block.totalBasementFloor : 'no' }} basement floor<span v-if="block.totalBasementFloor > 1">s</span></strong>
                                                    , and start with <strong>floor {{ block.firstFloorType}}</strong>.
                                    </span>
                                </div>
                            </div>
                        </div>
                     </div> <!-- else -->
                    <!-- back, next button -->
                    <div class="form-field">
                        <div class="form-field-nav">
                            <a v-on:click="() => {
                                currentStep = Steps.CREATE_BLOCK_FLOOR_PLAN_IMAGE_FOR_LOCATION;
                                //locationSelectedGridPresetOption = null;
                                //locationFloorPlanImage = null;
                                //newLocation.blocks = [];
                                locationSelectedTileIndex = -1;
                                paintCanvas();
                            }"><i class="fa fa-chevron-circle-left"></i> Back</a>

                            <a :style="createFloorCurrentBlock >= 0 ? 'color: var(--shadow) !important; cursor: not-allowed;' : ''" 
                                v-on:click="() => {
                                    if (createFloorCurrentBlock < 0) {
                                        showAlert('you done');
                                    } else {

                                    }
                                }">Next <i class="fa fa-chevron-circle-right"></i>
                            </a>
                        </div>                    
                    </div> <!-- back, next button -->
                </div>
                <!-- this step is when have no floor plan image for location, not yet implemented -->
                <div v-if="currentStep === Steps.CREATE_BLOCK_FOR_LOCATION">
                    <div class="form-field">
                        <div class="form-field-title">
                            Ok I don't have any floor plan images, so what?
                        </div>
                    </div>
                    <!-- back, next button -->
                    <div class="form-field">
                        <div class="form-field-nav">
                            <!-- back button -->
                            <a v-on:click="() => {
                                currentStep = Steps.ASK_LOCATION_FLOOR_PLAN_IMAGE;
                            }"><i class="fa fa-chevron-circle-left"></i> Back</a>
                            <!-- next button -->
                            <a v-on:click="() => {
                                
                            }">Next <i class="fa fa-chevron-circle-right"></i></a>   
                        </div>
                    </div> <!-- back, next button -->
                </div>
            </div>
        </div>
    </div>
</template>

<script>
// import Vue from 'vue';
import Server from '@/config/config';
// import fileBase64 from 'vue-file-base64';

export default {
    components: {
        // fileBase64
    },
    created() {
        let url = `${Server.LOCATION_API_PATH}/${this.$route.params.locationId}`;
        this.axios.get(url)
            .then((res) => {
                if (res.data) {
                    this.location = res.data;
                }
            })
    },
    data() {
        return {
            location: null,
            newLocation: null,
            locationFloorPlanImage: null,
            // newLocation.blocks: [],
            newBlock: null,
            newFloor: {
                name: '',
                imageBase64: '',
                tiles: [],
            },
            selectedFirstFloorType: 'G',
            FirstFloorType: {
                Ground: 'G',
                FloorOne: '1',
            },
            totalFloor: -1,
            totalBasementFloor: -1,
            newTile: {
                name: '',
            },
            currentFloorIndex: -1,
            tilePrefix: 'none',
            tilePrefixCustom: '',
            totalTiles: -1,
            currentTileIndex: -1,
            // step data - start
            currentStep: 0,
            createFloorCurrentBlock: 0,
            Steps: {
                ASK_LOCATION_FLOOR_PLAN_IMAGE: 0,
                CREATE_BLOCK_FLOOR_PLAN_IMAGE_FOR_LOCATION: 1.1,
                CREATE_BLOCK_FOR_LOCATION: 1.2,
                CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS: 2.1,
                CREATE_FLOOR_FOR_BLOCKS: 2.2,
            },
            haveLocationFloorPlanImage: true,
            // havaFloorFloorPlanImage: true,
            editingBlockFloor: false,
            // step data - end

            // paint tool data - start
            locationBackground: null,
            currentLocationPaintToolMode: 0,
            paintToolMode: {
                Preset: 0,
                Rectangle: 1,
                Hand: 2,
            },
            polyList: [],
            radius: 5,
            canvasMouseDown: false,
            // location - start
            locationSelectingPointIndex: -1,
            locationGridPreset: null,
            locationSelectedGridPresetOption: null,
            locationGridCustomColumns: 1,
            locationGridCustomRows: 1,
            locationSelectedTileIndex: -1,
            // location - end
            // floorSelectingPointIndex: -1,
            // floorGridPreset: null,
            // floorSelectedGridPresetOption: null,
            // floorGridCustomColumns: 1,
            // floorGridCustomRows: 1,
            // floorSelectedTileIndex: -1,
            // paint tool data - end
        }
    },
    methods: {
        getFile(file) {
            if (file) {
                var canvas = null;
                var canvasContext = null;
                var background = null;
                background = new Image();
                background.src = file.base64;
                if (this.currentStep === this.Steps.CREATE_BLOCK_FLOOR_PLAN_IMAGE_FOR_LOCATION) {
                    canvas = this.$refs.locationCanvas;
                    canvasContext = canvas.getContext('2d');

                    this.locationSelectingPointIndex = -1;
                    this.locationGridPreset = null;
                    this.locationSelectedGridPresetOption = null;
                    this.locationGridCustomColumns = 1;
                    this.locationGridCustomRows = 1;
                    this.locationSelectedTileIndex = -1;
                    this.locationFloorPlanImage = file;

                    this.newLocation = {
                        id: this.location.Id,
                        name: this.location.Name,
                        address: this.location.Address,
                        description: this.location.Description,
                        longitude: this.location.Longitude,
                        latitude: this.location.Latitude,
                        paintToolMode: this.currentLocationPaintToolMode,
                        imageBase64: file.base64,
                        blocks: [],
                        background: background,
                    };
                } 
                // else if (this.currentStep == this.Steps.CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS) {
                //     canvas = this.$refs.floorCanvas;
                //     canvasContext = canvas.getContext('2d');
                //     this.floorSelectingPointIndex = -1;
                //     this.floorGridPreset = null;
                //     this.floorSelectedGridPresetOption = null;
                //     this.floorGridCustomColumns = 1;
                //     this.floorGridCustomRows = 1;
                //     this.floorSelectedTileIndex = -1;

                //     let floor = this.newLocation.blocks[this.createFloorCurrentBlock].floors[this.currentFloorIndex];
                //     floor.imageFile = file;
                //     floor.background = background;
                // }

                background.onload = () => {
                    canvas.width = background.width;
                    canvas.height = background.height;
                    canvasContext.drawImage(background, 0, 0);
                };        
                let context = this;
                // let canvas = this.$refs.locationCanvas;
                // let canvasContext = this.$refs.locationCanvas.getContext('2d');
                canvas.addEventListener('mousemove', (event) => {
                    if (context.currentStep != context.Steps.CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS) {
                        var mousePos = {
                            x: event.clientX - canvas.getBoundingClientRect().left,
                            y: event.clientY - canvas.getBoundingClientRect().top
                        };
                        context.paintCanvas(canvas, mousePos.x, mousePos.y);
                    }
                });
                canvas.addEventListener('mousedown', (event) => {
                    if (context.currentStep != context.Steps.CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS) {
                        context.canvasMouseDown = true;
                        var mousePos = {
                            x: event.clientX - canvas.getBoundingClientRect().left,
                            y: event.clientY - canvas.getBoundingClientRect().top
                        };
                        if (context.currentLocationPaintToolMode == context.paintToolMode.Hand) {
                            for (var i = 0; i < context.newBlock.points.length; i++) {
                                let point = context.newBlock.points[i];
                                let distX = mousePos.x - point.x;
                                let distY = mousePos.y - point.y;
                                let distance = Math.sqrt((distX * distX) + (distY * distY));
                                if (distance <= context.radius) {
                                    context.locationSelectingPointIndex= i;
                                    break;
                                } else {
                                    context.locationSelectingPointIndex= -1;
                                }
                            }
                            if (context.locationSelectingPointIndex== -1) {
                                context.canvasClick(canvas, mousePos.x, mousePos.y);
                            }
                        }
                    }
                });
                canvas.addEventListener('mouseup', (event) => {
                    context.canvasMouseDown = false;
                    // if (!context.currentLocationPaintToolMode == this.paintToolMode.Preset && (context.newBlock.points.length > 0 || context.polyList.length > 0)) {
                    //     // context.locationSelectingPointIndex= -1;
                    //     context.drawPoints();
                    // }
                });
                canvas.addEventListener('click', (event) => {
                    if (context.currentStep != context.Steps.CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS) {
                        if (context.currentLocationPaintToolMode == this.paintToolMode.Preset) {
                            var mousePos = {
                                x: event.clientX - canvas.getBoundingClientRect().left,
                                y: event.clientY - canvas.getBoundingClientRect().top
                            };
                            context.canvasClick(canvas, mousePos.x, mousePos.y);
                        }
                    }
                }); 
            }
        },
        showAlert(msg) {
            alert(msg);
        },
        // paint methods - start
        clearCanvas() {
            var canvas = this.$refs.locationCanvas;
            var canvasContext = canvas.getContext('2d');
            canvasContext.clearRect(0, 0, canvas.width, canvas.height);
            canvasContext.drawImage(this.newLocation.background, 0, 0);

            // if (this.currentStep == this.Steps.CREATE_FLOOR_FLOOR_PLAN_IMAGE_FOR_BLOCKS 
            //         && this.currentFloorIndex >= 0
            //         && this.newLocation.blocks[this.createFloorCurrentBlock].floors[this.currentFloorIndex].background) {
            //     canvas = this.$refs.floorCanvas;
            //     canvasContext = canvas.getContext('2d');
            //     canvasContext.clearRect(0, 0, canvas.width, canvas.height);

            //     let floor = this.newLocation.blocks[this.createFloorCurrentBlock].floors[this.currentFloorIndex];
            //     canvas.width = floor.background.width;
            //     canvas.height = floor.background.height;
            //     canvasContext.drawImage(floor.background, 0, 0);
            // }
            // canvasContext.beginPath();
            // canvasContext.moveTo(0,0);
            // canvasContext.stroke();
        },
        paintCanvas(canvas, mouseX, mouseY) {
            if (this.locationFloorPlanImage) {
                // let canvasContext = canvas.getContext('2d');
                if (this.currentLocationPaintToolMode == this.paintToolMode.Preset && this.locationGridPreset) {
                    if (this.newLocation.blocks.length == 0) {
                        let tileWidth = canvas.width / this.locationGridPreset.column;
                        let tileHeight = canvas.height / this.locationGridPreset.row;
                        this.clearCanvas();
                        for (var row = 0; row < this.locationGridPreset.row; row++) {
                            for (var col = 0; col < this.locationGridPreset.column; col++) {
                                let x = col * canvas.width / this.locationGridPreset.column;
                                let y = row * canvas.height / this.locationGridPreset.row;              

                                let tileOrderNumber = (col + 1) + (row * this.locationGridPreset.column);

                                this.newBlock = {
                                    id: (tileOrderNumber - 1),
                                    name: `${tileOrderNumber}`,
                                    totalFloor: 1,
                                    totalBasementFloor: 0,
                                    firstFloorType: this.FirstFloorType.Ground,
                                    points: [],
                                    floors: [],
                                }
                                this.newBlock.name = `${tileOrderNumber}`;
                                this.newBlock.points.push({x: x, y: y});
                                this.newBlock.points.push({x: (x + tileWidth), y: y});
                                this.newBlock.points.push({x: (x + tileWidth), y: (y + tileHeight)});
                                this.newBlock.points.push({x: x, y: (y + tileHeight)});

                                this.newLocation.blocks.push(this.newBlock);

                                this.drawPoly(canvas, tileOrderNumber - 1, this.newBlock.points, false, this.newBlock.name, null, null);
                            }
                        }
                    } else {
                        this.clearCanvas();
                        for (var i = 0; i < this.newLocation.blocks.length; i++) {
                            let block = this.newLocation.blocks[i];
                            this.drawPoly(canvas, i, block.points, false, block.name, mouseX, mouseY);
                        }
                    }
                } else if (this.canvasMouseDown && this.locationSelectingPointIndex>= 0) {
                    this.clearCanvas();
                    this.newBlock.points[this.locationSelectingPointIndex].x = mouseX;
                    this.newBlock.points[this.locationSelectingPointIndex].y = mouseY;
                    this.drawPoints(canvas);
                }
            }
        },
        drawPoints(canvas) {
            this.clearCanvas();
            // if (this.newBlock.points.length > 0) {
            //     this.drawPoly(this.newBlock, true);
            // }
            for (var i = 0; i < this.newLocation.blocks.length; i++) {
                let block = this.newLocation.blocks[i];
                this.drawPoly(canvas, i, block.points, false, block.name, null, null);
            }
            
        },
        drawPoly(canvas, index, points, drawPoints, name, mouseX, mouseY) {
            // this.clearCanvas();
            let canvasContext = canvas.getContext('2d');
            if (points.length > 0) {
                // drawDot - start
                if (drawPoints) {
                    canvasContext.fillStyle = 'rgba(255,0,0,0.4)';
                    points.forEach(point => {
                        canvasContext.beginPath();
                        canvasContext.arc(point.x, point.y, this.radius, 0, 2 * Math.PI, false);
                        canvasContext.closePath();
                        canvasContext.fill();
                    });
                }
                // drawDot - end
                canvasContext.beginPath();
                // fill points - start 
                canvasContext.strokeStyle = "rgba(0,0,0,0.6)";
                canvasContext.lineWidth = '2';
                if (index == this.locationSelectedTileIndex 
                    || (mouseX && mouseY && (mouseX >= points[0].x && mouseX <= points[1].x
                                && (mouseY >= points[0].y && mouseY <= points[3].y)))) {
                   
                    // canvasContext.strokeStyle = "red";
                    // canvasContext.lineWidth = "2";
                    canvasContext.fillStyle = 'rgba(255,0,0,0.4)';
                } else {
                    canvasContext.lineWidth = "1";
                    canvasContext.fillStyle = 'rgba(0,0,0,0.1)';
                }
                canvasContext.moveTo(points[0].x, points[0].y);
                let minX = points[0].x;
                let maxX = points[0].x;
                let minY = points[0].y;
                let maxY = points[0].y;
                for(var i = 1; i < points.length; i++) {
                    canvasContext.lineTo(points[i].x, points[i].y); 
                    if (name && name.length > 0) {
                        if (points[i].x < minX) {
                            minX = points[i].x;
                        }
                        if (points[i].x > maxX) {
                            maxX = points[i].x;
                        }
                        if (points[i].y < minY) {
                            minY = points[i].y;
                        }
                        if (points[i].y > maxY) {
                            maxY = points[i].y;
                        }
                    }                
                }
                canvasContext.closePath();
                canvasContext.fill();
                canvasContext.stroke();
                // fill points - end 
                // draw points name - start
                if (name && name.length > 0) {
                    canvasContext.strokeStyle = "rgba(0,0,0,0.6)";
                    canvasContext.lineWidth = '2';
                    canvasContext.font = '2rem Roboto';
                    canvasContext.fillStyle = "black";
                    canvasContext.textAlign = 'center';
                    canvasContext.fillText(`${name}`, (minX + maxX) / 2, (maxY + minY) / 2);
                }
                // draw points name - end
            }
        },
        canvasClick(canvas, mouseX, mouseY) {
            if (this.locationFloorPlanImage) {
                // let canvasContext = canvas.getContext('2d');    
                if (this.currentLocationPaintToolMode == this.paintToolMode.Preset && this.locationGridPreset) {      
                    // this.clearCanvas();          
                    let tileWidth = canvas.width / this.locationGridPreset.column;
                    let tileHeight = canvas.height / this.locationGridPreset.row;
                    for (var row = 0; row < this.locationGridPreset.row; row++) {
                        for (var col = 0; col < this.locationGridPreset.column; col++) {
                            let x = col * canvas.width / this.locationGridPreset.column;
                            let y = row * canvas.height / this.locationGridPreset.row;
              
    
                            if ((mouseX && mouseY) && (mouseX >= x && mouseX <= (x + tileWidth) 
                                                            && (mouseY >= y && mouseY <= (y + tileHeight)))) {
                                this.locationSelectedTileIndex = col + (row * this.locationGridPreset.column);
                                this.newBlock = this.newLocation.blocks[this.locationSelectedTileIndex];        
                            }
                        }
                    }
                } else if (this.currentLocationPaintToolMode == this.paintToolMode.Hand) {                
                    this.newBlock.points.push({x: mouseX, y: mouseY});     
                }
            }
        },
        // paint methods - end
        createBlockFloors(index) {
            let floors = [];
            for (var i = 0; i < this.totalFloor; i++) {
                let floor = {
                    name: '',
                    tiles: [],
                }
                if (i == 0) {
                    floor.name = this.selectedFirstFloorType;
                } else if (this.selectedFirstFloorType == this.FirstFloorType.Ground) {
                    floor.name = `${i}`;
                } else if (this.selectedFirstFloorType == this.FirstFloorType.FloorOne) {
                    floor.name = `${i + 1}`;
                }
                floors.push(floor);
            }
            if (this.totalBasementFloor > 0) {
                for (var i = 1; i <= this.totalBasementFloor; i++) {
                    let floor = {
                        name: `B${i}`,
                        tiles: [],
                    }
                    floors.unshift(floor); // add to the head of list
                }
            }
            this.newLocation.blocks[index].floors = floors.slice().reverse();
        },
        // consoleLog() {
        //     console.log(this.$refs.floorSelectFile);
        // }
        makeTiles() {
            let floor = this.newLocation.blocks[this.createFloorCurrentBlock].floors[this.currentFloorIndex];
            let prefix = '';
            switch (this.tilePrefix) {
                case 'none': {
                    prefix = '';
                    break;
                }
                case 'floororder': {
                    prefix = floor.name;
                    break;
                }
                case 'custom': {
                    prefix = this.tilePrefixCustom;
                    break;
                }
            }
            if (this.totalTiles != floor.tiles.length) {
                if (this.totalTiles > floor.tiles.length) {
                    while(floor.tiles.length != this.totalTiles) {
                        let newTile = {
                            name: `${prefix}${floor.tiles.length + 1}`,
                        }
                        floor.tiles.push(newTile);
                    }
                } else if (this.totalTiles < floor.tiles.length) {
                    while(floor.tiles.length != this.totalTiles) {
                        floor.tiles.pop();
                    }
                }
            }
        },
        changeNameAllTiles() {
            this.newLocation.blocks[this.createFloorCurrentBlock].floors.forEach(floor => {
                let prefix = '';
                switch (this.tilePrefix) {
                    case 'none': {
                        prefix = '';
                        break;
                    }
                    case 'floororder': {
                        prefix = floor.name;
                        break;
                    }
                    case 'custom': {
                        prefix = this.tilePrefixCustom;
                        break;
                    }
                }
                for (var i = 0; i < floor.tiles.length; i++) {
                    floor.tiles[i].name = `${prefix}${i + 1}`
                }
            });
        }
    },    
    watch: {
        'locationSelectedGridPresetOption': function() {
            if (this.currentStep === this.Steps.CREATE_BLOCK_FLOOR_PLAN_IMAGE_FOR_LOCATION) {
                if (this.locationSelectedGridPresetOption) {
                    if (this.locationSelectedGridPresetOption == 'custom') {
                        this.locationGridPreset = {
                            column : this.locationGridCustomColumns,
                            row: this.locationGridCustomRows,
                        };
                    } else {
                        this.locationGridPreset = this.locationSelectedGridPresetOption;
                    }
                    this.clearCanvas();
                    this.newLocation.blocks = [];    
                    this.paintCanvas(this.$refs.locationCanvas, null, null);
                }
            }
        },
        'currentLocationPaintToolMode': function() {
            this.clearCanvas();
            if (this.currentLocationPaintToolMode == this.paintToolMode.Preset && this.locationSelectedGridPresetOption) {
                this.paintCanvas(this.$refs.locationCanvas, null, null);
            } 
            // else if (this.currentLocationPaintToolMode == this.paintToolMode.Hand && this.newBlock.points.length > 0) {
            //     this.drawPoints();
            // }
        },
        'newBlock.name': function() {
            if (this.locationSelectedTileIndex >= 0) {
                this.newLocation.blocks[this.locationSelectedTileIndex].name = this.newBlock.name;
            }
            this.drawPoints(this.$refs.locationCanvas);
        },
        'locationGridCustomColumns': function() {
            this.locationGridPreset = {
                column: this.locationGridCustomColumns,
                row: this.locationGridCustomRows,
            }
            this.clearCanvas();
            this.newLocation.blocks = [];    
            this.paintCanvas(this.$refs.locationCanvas, null, null);
        },
        'locationGridCustomRows': function() {
            this.locationGridPreset = {
                column: this.locationGridCustomColumns,
                row: this.locationGridCustomRows,
            }
            this.clearCanvas();
            this.newLocation.blocks = [];
            this.paintCanvas(this.$refs.locationCanvas, null, null);
        },
        'totalFloor': function() {
            this.currentFloorIndex = -1;
            this.currentTileIndex = -1;
            if (this.totalFloor == '' || this.totalFloor <= 0) {
                this.totalFloor = 1;
            } else {
                this.createBlockFloors(this.createFloorCurrentBlock);
            }
        },
        'totalBasementFloor': function() {
            this.currentFloorIndex = -1;
            this.currentTileIndex = -1;
            this.createBlockFloors(this.createFloorCurrentBlock);
        },
        'selectedFirstFloorType': function() {
            this.createBlockFloors(this.createFloorCurrentBlock);
        },
        'totalTiles': function() {
            if (this.totalTiles == '' || this.totalTiles <= 0) {
                this.totalTiles = 1;
            } else {
                this.makeTiles();
            }
        },
        'tilePrefix': function() {
            this.changeNameAllTiles();
        },
        'tilePrefixCustom': function() {
            if (this.newLocation.blocks[this.createFloorCurrentBlock].floors[this.currentFloorIndex].tiles.length > 0 
                    && this.tilePrefix == 'custom') {
                this.changeNameAllTiles(); 
            }
        }
    }
}
</script>

<style scoped>
.form {
  /* background-color: white; */
  padding: 0 !important;
}
.form-title {
  border-bottom: 1px solid #e0e0e0;
  padding: 1rem 2rem;
  /* padding: 1rem 0rem; */
}

.form-title-start {
  /* position: relative;
  top: 10px; */
  /* font-weight: bold;
  font-size: 20px; */
  /* color: #616161; */
}

.form-title-end {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  /* align-content: center; */
}

.form-title-end button {
  /* font-weight: bold;
        color: white;
        border: 1px solid transparent;
        border-radius: 10px;
        padding: .6rem 1.5rem; */
}

#btn-cancel {
  background-color: #bdbdbd;
  color: white;
  margin-right: 0.6rem;
}

#btn-add {
  background-color: var(--primary-color);
  color: white;
}

.form-content {
  font-size: 1rem;
  /* position: fixed;
  max-height: 70%; */
  width: 100%;
  /* overflow-y: scroll; */
  /* display: flex;
        flex-direction: column;  */
}

.form-field {
  /* margin-bottom: 5px; */
  padding: 1rem 2rem; 
  /* padding: 1rem 0rem;  */
}

.form-field input[type="text"],
.form-field textarea {
  width: 40%;
}

.form-field textarea {
  min-height: 5rem;
  max-height: 10rem;
}

.form-field-title {
  font-weight: 500;
}

.form-field .form-field-input {
  margin-top: 0.5rem;
}

.form-field-nav {
    user-select: none;
    width: 40%;
    /* padding-top: 1rem; */
}

.form-field-nav a:last-child {
    float: right;
}

.btn-plus {
  color: black;
}

.box-danger {
  border: 1px solid var(--danger-color) !important;
}
</style>
