<template>
    <div v-if="location" style="padding: 0 !important">
        <div style="padding: 1rem 2rem 0rem 2rem">
            <router-link to="/location">
                <a><span class="fa fa-chevron-left"></span> Back to Location</a>
            </router-link>
        </div>
        <div class="form">
            <div class="form-title">
                <h1 style="font-weight: bold; font-size: 1.5rem">{{ location.Name }}</h1>
                <h2 style="font-size: 1rem; margin-top: .5rem">{{ location.Address }}</h2>
            </div>
            <div class="form-content">
                <div v-if="currentStep == Steps.ASK_LOCATION_FLOOR_PLAN_IMAGE">
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
                                    currentStep = Steps.LOCATION_FLOOR_PLANE_IMAGE.HAVE_IMAGE_UPLOAD;
                                } else {
                                    currentStep = Steps.LOCATION_FLOOR_PLANE_IMAGE.HAVE_NO_IMAGE_NAMING;
                                }
                            }">Next <i class="fa fa-chevron-circle-right"></i></a>    
                        </div>
                    </div>
                </div>
                <div v-if="currentStep == Steps.LOCATION_FLOOR_PLANE_IMAGE.HAVE_IMAGE_UPLOAD">
                    <div class="form-field">
                        <div class="form-field-title">
                            Upload floor plan image of location {{ location.Name }}
                        </div>
                        <div class="form-field-input" style="display: flex !important">
                            <file-base64 :done="getFile"></file-base64>
                        </div>
                    </div>
                </div>
                <div v-show="currentStep == Steps.LOCATION_FLOOR_PLANE_IMAGE.HAVE_IMAGE_UPLOAD || currentStep == Steps.CREATE_FLOOR_FOR_BLOCKS">
                    <div class="form-field" v-show="floorPlanImageFile">
                        <canvas :style="currentStep == Steps.LOCATION_FLOOR_PLANE_IMAGE.HAVE_IMAGE_UPLOAD ? 
                                                            'cursor: pointer' : (currentStep == Steps.CREATE_FLOOR_FOR_BLOCKS ?
                                                                                'cursor: not-allowed' : '')" ref="myCanvas"></canvas> 
                    </div>
                </div>
                <div v-if="currentStep == Steps.LOCATION_FLOOR_PLANE_IMAGE.HAVE_IMAGE_UPLOAD">
                    <div class="form-field" v-if="floorPlanImageFile && !newBlock && (currentPaintToolMode == paintToolMode.Preset && blocks.length == 0)">
                            <a v-on:click="() => {
                                newBlock = {name: '', points: [], floors: []};
                            }"><i class="fa fa-plus-circle"></i> Add new block</a>
                        </div>
                    <div v-if="floorPlanImageFile && newBlock">
                        <div class="form-field">
                            <div>
                                Paint helper tool:
                                <label class="radio" v-on:click="currentPaintToolMode = paintToolMode.Preset">
                                    <input name="paintToolMode" :checked="currentPaintToolMode == paintToolMode.Preset" type="radio">
                                    Preset
                                </label>
                                <label class="radio" v-on:click="currentPaintToolMode = paintToolMode.Rectangle">
                                    <input name="paintToolMode" :checked="currentPaintToolMode == paintToolMode.Rectangle" type="radio">
                                    Rectangle tool
                                </label>
                                <label class="radio" v-on:click="currentPaintToolMode = paintToolMode.Hand">
                                    <input name="paintToolMode" :checked="currentPaintToolMode == paintToolMode.Hand" type="radio">
                                    By hand
                                </label>
                            </div>
                            <div class="field is-horizontal">
                                <div class="select" v-if="currentPaintToolMode == paintToolMode.Preset">
                                    <select v-model="selectedGridPreset">
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
                                <div v-if="selectedGridPreset == 'custom'">
                                    <span style="position: relative; top: .5rem; margin-left: 1rem; align-text: right;">Column: </span>
                                    <span><input style="width: 4rem; text-align: right;" class="input" type="number" min="1" v-model="customColumns"> </span>
                                    <span style="position: relative; top: .5rem; margin-left: 1rem;"> Row: </span>
                                    <span><input style="width: 4rem; text-align: right;" class="input" type="number" min="1" v-model="customRows"> </span>
                                </div>
                            </div>
                            <div>
                                <div v-if="currentPaintToolMode == paintToolMode.Hand">
                                    <button class="button" :disabled="newBlock.points.length == 0" v-on:click="() => {
                                        newBlock.points.pop(); 
                                        if(newBlock.points.length > 0) {
                                            drawPoints();
                                        } else {
                                            clearCanvas();
                                        }
                                    }">Undo</button>
                                    <button class="button" :disabled="selectingPointIndex == -1" v-on:click="() => {
                                        newBlock.points.splice(selectingPointIndex, 1); 
                                        if(newBlock.points.length > 0) {
                                            drawPoints();
                                        } else {
                                            clearCanvas();
                                        }
                                        selectingPointIndex = -1;
                                    }">Remove</button>
                                    <button class="button" :disabled="newBlock.points.length == 0 || blocks.length == 0" v-on:click="() => {
                                        newBlock = {name: '', points: [], floor: []};    
                                        blocks = [];
                                        selectingPointIndex = -1;
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
                                            //selectingPointIndex = -1;
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
                        </div>
                        <div v-if="newBlock">
                            <div class="form-field">
                                <div class="form-field-title">
                                    Notice: - Please use paint helper tool to select a block from your floor plan image. <br/>
                                    <span style="color: transparent;">Notice: </span>- For hand tool, you must draw at least 3 points to be accepted as a legal block.
                                </div>
                            </div>
                            <div v-if="currentPaintToolMode == paintToolMode.Preset && selectedTileIndex >= 0">
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
                                        if (currentPaintToolMode == paintToolMode.Preset) {
                                            selectedTileIndex = -1;
                                            newBlock = {name: '', points: [], floors: []};
                                        }
                                        // newBlock = null;
                                    }"><i class="fa fa-check-circle"></i> {{ currentPaintToolMode == paintToolMode.Preset ? 'Save changes' : 'Create block' }}</a>
                                </div>
                            </div>
                        </div>                        
                    </div>
                    <!-- back, next button -->
                    <div class="form-field">
                        <div class="form-field-nav">
                            <!-- back button -->
                            <a v-on:click="() => {
                                currentStep = Steps.ASK_LOCATION_FLOOR_PLAN_IMAGE;
                                floorPlanImageFile = null;
                                blocks = [];
                                newBlock = null;
                            }"><i class="fa fa-chevron-circle-left"></i> Back</a>
                            <!-- next button -->
                            <!-- disable when no block created, so need to create at least a block to enable -->
                            <a :style="blocks.length == 0 ? 'color: var(--shadow) !important; cursor: not-allowed': ''" v-on:click="() => {
                                if (blocks.length > 0) {
                                    currentStep = Steps.CREATE_FLOOR_FOR_BLOCKS;
                                    selectedTileIndex = createFloorCurrentBlock;
                                    paintCanvas(null, null);
                                }                      
                            }">Next <i class="fa fa-chevron-circle-right"></i></a>    
                        </div>
                    </div> <!-- back, next button -->
                </div>
                <!-- this step is to create floors info of blocks -->
                <div v-if="currentStep == Steps.CREATE_FLOOR_FOR_BLOCKS">
                    <!-- currently, there is a block is selecting to create/edit floors info -->
                    <div v-if="createFloorCurrentBlock >= 0">
                        <div class="form-field">
                            <!-- creating block floor -->
                            <div class="form-field-title" v-if="!editingBlockFloor">
                                Please provide some information that help create floors for Block {{ blocks[createFloorCurrentBlock].name }}.                        
                            </div>
                            <!-- editing block floor -->
                            <div class="form-field-title" v-else>
                                Editing floors information for Block {{ blocks[createFloorCurrentBlock].name }}.                        
                            </div>
                        </div>
                        <div class="form-field">
                            <div class="form-field-title">
                                <span style="position: relative; top: .5rem">Block {{ blocks[createFloorCurrentBlock].name }} has </span>
                                <span>
                                    <!-- creating block floor -->
                                    <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="1" v-model="totalFloor" v-if="!editingBlockFloor">
                                    <!-- editing block floor -->
                                    <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="1" v-model="blocks[createFloorCurrentBlock].totalFloor" v-else>
                                </span>
                                <span style="position: relative; top: .5rem">floor<span v-if="totalFloor > 1">s</span>,</span>
                                <span style="position: relative; top: .5rem"> and has </span>
                                <span>
                                    <!-- creating block floor -->
                                    <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="0" v-model="totalBasementFloor" v-if="!editingBlockFloor">
                                    <!-- editing block floor -->
                                    <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="0" v-model="blocks[createFloorCurrentBlock].totalBasementFloor" v-else>
                                </span>
                                <span style="position: relative; top: .5rem"> basement floor<span v-if="totalBasementFloor > 1">s</span>.</span>
                            </div>
                        </div>
                        <div class="form-field">
                            <div class="form-field-title">
                                What would you call the first floor of Block {{ blocks[createFloorCurrentBlock].name }} ?  
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
                                <label class="radio" v-on:click="() => {blocks[createFloorCurrentBlock].firstFloorType = FirstFloorType.Ground}">
                                    <input type="radio" name="firstFloorType" :checked="blocks[createFloorCurrentBlock].firstFloorType == FirstFloorType.Ground">
                                    Ground
                                </label>
                                <label class="radio" v-on:click="() => {blocks[createFloorCurrentBlock].firstFloorType = FirstFloorType.FloorOne}">
                                    <input type="radio" name="firstFloorType" :checked="blocks[createFloorCurrentBlock].firstFloorType == FirstFloorType.FloorOne">
                                    Floor 1
                                </label>
                            </div>
                        </div>
                        <!-- display floors visually -->
                        <div class="form-field">
                            <div style="display: grid; grid-template-columns: 20% 80%">
                                <div>
                                    <div :key="'blockFloors' + index" v-for="(floor, index) in blocks[createFloorCurrentBlock].floors">
                                        <button class="button" style="text-align: center; width: 4rem" v-on:click="currentFloorIndex = index">{{ floor.name }}</button>
                                    </div>
                                </div>
                                <div>
                                    <span v-if="currentFloorIndex >= 0">
                                        Floor {{ blocks[createFloorCurrentBlock].floors[currentFloorIndex].name }} selected.
                                    </span>
                                </div>
                            </div>
                        </div><!-- display floors visually -->
                        <div class="form-field">
                            <!-- click this <a> to create/edit floors info of a block -->
                            <a v-on:click="() => {                                
                                if (!editingBlockFloor) {
                                    blocks[createFloorCurrentBlock].totalFloor = totalFloor;
                                    blocks[createFloorCurrentBlock].totalBasementFloor = totalBasementFloor;
                                    blocks[createFloorCurrentBlock].firstFloorType = selectedFirstFloorType;
                                    // resetting values - start
                                    totalFloor = 1;
                                    totalBasementFloor = 0;
                                    selectedFirstFloorType = FirstFloorType.Ground;
                                    // resetting values - end
                                    ++createFloorCurrentBlock;
                                    selectedTileIndex = createFloorCurrentBlock;
                                    // at the end of block list, no need move to next block to create more floor
                                    if (createFloorCurrentBlock >= blocks.length) {
                                        createFloorCurrentBlock = -1; // createFloorCurrentBlock = -1 to display the review
                                        selectedTileIndex = -1; // no more block hightlight on the canvas
                                    }
                                    // repaint the canvas the display the next block to create floors info
                                    paintCanvas(null, null);
                                } else {
                                    createFloorCurrentBlock = -1;
                                    editingBlockFloor = false;
                                }
                            }"><i class="fa fa-check-circle"></i> {{ editingBlockFloor ? 'Save changes ' : 'Finish creating floors for '}} Block {{ blocks[createFloorCurrentBlock].name }}</a>
                        </div>
                    </div>
                    <!-- else, this happens after created floors for all the blocks or save changes of an editing block -->
                    <div v-else>
                        <div class="form-field">
                            <div class="form-field-title">
                                Please recheck the floors information of <span v-if="blocks.length == 1">this block</span><span v-if="blocks.length > 1">these blocks</span> (click on a block to edit floor information):
                            </div>
                            <div :key="'makeBlockFloor' + block.id" v-for="block in blocks">
                                <div style="padding-left: 1rem; margin-bottom: .5rem">
                                    <!-- click the <a> below to edit selected block -->
                                    <span>- <a v-on:click="() => {
                                                createFloorCurrentBlock = block.id;
                                                selectedTileIndex = block.id;
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
                                currentStep = Steps.LOCATION_FLOOR_PLANE_IMAGE.HAVE_IMAGE_UPLOAD;
                                //selectedGridPreset = null;
                                //floorPlanImageFile = null;
                                //blocks = [];
                                selectedTileIndex = -1;
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
                <div v-if="currentStep == Steps.LOCATION_FLOOR_PLANE_IMAGE.HAVE_NO_IMAGE_NAMING">
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
            floorPlanImageFile: null,
            blocks: [],
            newBlock: null,
            newFloor: {
                name: '',
                imageBase64: '',
                tiles: [],
            },
            selectedFirstFloorType: 'Ground',
            FirstFloorType: {
                Ground: 'Ground',
                FloorOne: '1',
            },
            totalFloor: 1,
            totalBasementFloor: 0,
            newTile: {
                name: '',
                points: [],
            },
            currentFloorIndex: -1,
            // step data - start
            currentStep: 0,
            createFloorCurrentBlock: 0,
            Steps: {
                ASK_LOCATION_FLOOR_PLAN_IMAGE: 0,
                LOCATION_FLOOR_PLANE_IMAGE: {
                    HAVE_IMAGE_UPLOAD: 1.1,
                    HAVE_NO_IMAGE_NAMING: 1.2,
                },
                CREATE_FLOOR_FOR_BLOCKS: 2,
                FLOOR_FLOOR_PLANE_IMAGE: {
                    HAVE_IMAGE_UPLOAD: 3.1,
                    HAVE_NO_IMAGE_NAMING: 3.2,
                },
            },
            haveLocationFloorPlanImage: true,
            havaFloorFloorPlanImage: true,
            editingBlockFloor: false,
            // step data - end

            // paint tool data - start
            background: null,
            currentPaintToolMode: 0,
            paintToolMode: {
                Preset: 0,
                Rectangle: 1,
                Hand: 2,
            },
            polyList: [],
            radius: 5,
            canvasMouseDown: false,
            selectingPointIndex: -1,
            gridPreset: null,
            selectedGridPreset: null,
            customColumns: 1,
            customRows: 1,
            selectedTileIndex: -1,
            // paint tool data - end
        }
    },
    methods: {
        getFile(file) {
            if (file) {
                this.selectedGridPreset = null;
                this.gridPreset = null;
                this.floorPlanImageFile = file;

                this.newLocation = {
                    Id: this.location.Id,
                    Name: this.location.Name,
                    Address: this.location.Address,
                    Description: this.location.Description,
                    Longitude: this.location.Longitude,
                    Latitude: this.location.Latitude,
                    ImageBase64: file.base64,
                };

                let canvas = this.$refs.myCanvas;
                let canvasContext = canvas.getContext('2d');
                this.background = new Image();
                this.background.src = file.base64;
                this.background.onload = () => {
                    canvas.width = this.background.width;
                    canvas.height = this.background.height;
                    canvasContext.drawImage(this.background, 0, 0);
                };        
                let context = this;
                // let canvas = this.$refs.myCanvas;
                // let canvasContext = this.$refs.myCanvas.getContext('2d');
                canvas.addEventListener('mousemove', (event) => {
                    if (context.currentStep != context.Steps.CREATE_FLOOR_FOR_BLOCKS) {
                        var mousePos = {
                            x: event.clientX - canvas.getBoundingClientRect().left,
                            y: event.clientY - canvas.getBoundingClientRect().top
                        };
                        context.paintCanvas(mousePos.x, mousePos.y);
                    }
                });
                canvas.addEventListener('mousedown', (event) => {
                    if (context.currentStep != context.Steps.CREATE_FLOOR_FOR_BLOCKS) {
                        context.canvasMouseDown = true;
                        var mousePos = {
                            x: event.clientX - canvas.getBoundingClientRect().left,
                            y: event.clientY - canvas.getBoundingClientRect().top
                        };
                        if (context.currentPaintToolMode == context.paintToolMode.Hand) {
                            for (var i = 0; i < context.newBlock.points.length; i++) {
                                let point = context.newBlock.points[i];
                                let distX = mousePos.x - point.x;
                                let distY = mousePos.y - point.y;
                                let distance = Math.sqrt((distX * distX) + (distY * distY));
                                if (distance <= context.radius) {
                                    context.selectingPointIndex = i;
                                    break;
                                } else {
                                    context.selectingPointIndex = -1;
                                }
                            }
                            if (context.selectingPointIndex == -1) {
                                context.canvasClick(mousePos.x, mousePos.y);
                            }
                        }
                    }
                });
                canvas.addEventListener('mouseup', (event) => {
                    context.canvasMouseDown = false;
                    // if (!context.currentPaintToolMode == this.paintToolMode.Preset && (context.newBlock.points.length > 0 || context.polyList.length > 0)) {
                    //     // context.selectingPointIndex = -1;
                    //     context.drawPoints();
                    // }
                });
                canvas.addEventListener('click', (event) => {
                    if (context.currentStep != context.Steps.CREATE_FLOOR_FOR_BLOCKS) {
                        if (context.currentPaintToolMode == this.paintToolMode.Preset) {
                            var mousePos = {
                                x: event.clientX - canvas.getBoundingClientRect().left,
                                y: event.clientY - canvas.getBoundingClientRect().top
                            };
                            context.canvasClick(mousePos.x, mousePos.y);
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
            let canvas = this.$refs.myCanvas;
            let canvasContext = this.$refs.myCanvas.getContext('2d');
            canvasContext.clearRect(0, 0, canvas.width, canvas.height);
            canvasContext.drawImage(this.background, 0, 0);
            // canvasContext.beginPath();
            // canvasContext.moveTo(0,0);
            // canvasContext.stroke();
        },
        paintCanvas(mouseX, mouseY) {
            if (this.floorPlanImageFile) {                
                let canvas = this.$refs.myCanvas;
                // let canvasContext = canvas.getContext('2d');

                if (this.currentPaintToolMode == this.paintToolMode.Preset && this.gridPreset) {
                    if (this.blocks.length == 0) {
                        let tileWidth = canvas.width / this.gridPreset.column;
                        let tileHeight = canvas.height / this.gridPreset.row;
                        this.clearCanvas();
                        for (var row = 0; row < this.gridPreset.row; row++) {
                            for (var col = 0; col < this.gridPreset.column; col++) {
                                let x = col * canvas.width / this.gridPreset.column;
                                let y = row * canvas.height / this.gridPreset.row;              

                                let tileOrderNumber = (col + 1) + (row * this.gridPreset.column);

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

                                this.blocks.push(this.newBlock);

                                this.drawPoly(tileOrderNumber - 1, this.newBlock.points, false, this.newBlock.name, null, null);
                            }
                        }
                    } else {
                        this.clearCanvas();
                        for (var i = 0; i < this.blocks.length; i++) {
                            let block = this.blocks[i];
                            this.drawPoly(i, block.points, false, block.name, mouseX, mouseY);
                        }
                    }
                } 
                else if (this.canvasMouseDown && this.selectingPointIndex >= 0) {
                    this.clearCanvas();
                    this.newBlock.points[this.selectingPointIndex].x = mouseX;
                    this.newBlock.points[this.selectingPointIndex].y = mouseY;
                    this.drawPoints();
                }
            }
        },
        drawPoints() {
            this.clearCanvas();
            // if (this.newBlock.points.length > 0) {
            //     this.drawPoly(this.newBlock, true);
            // }
            for (var i = 0; i < this.blocks.length; i++) {
                let block = this.blocks[i];
                this.drawPoly(i, block.points, false, block.name, null, null);
            }
            
        },
        drawPoly(index, points, drawPoints, name, mouseX, mouseY) {
            // this.clearCanvas();
            let canvasContext = this.$refs.myCanvas.getContext('2d');
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
                if (index == this.selectedTileIndex 
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
                for(var index = 1; index < points.length; index++) {
                    canvasContext.lineTo(points[index].x, points[index].y); 
                    if (name && name.length > 0) {
                        if (points[index].x < minX) {
                            minX = points[index].x;
                        }
                        if (points[index].x > maxX) {
                            maxX = points[index].x;
                        }
                        if (points[index].y < minY) {
                            minY = points[index].y;
                        }
                        if (points[index].y > maxY) {
                            maxY = points[index].y;
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
        canvasClick(mouseX, mouseY) {
            if (this.floorPlanImageFile) {
                let canvas = this.$refs.myCanvas;
                // let canvasContext = canvas.getContext('2d');    
                if (this.currentPaintToolMode == this.paintToolMode.Preset && this.gridPreset) {      
                    // this.clearCanvas();          
                    let tileWidth = canvas.width / this.gridPreset.column;
                    let tileHeight = canvas.height / this.gridPreset.row;
                    for (var row = 0; row < this.gridPreset.row; row++) {
                        for (var col = 0; col < this.gridPreset.column; col++) {
                            let x = col * canvas.width / this.gridPreset.column;
                            let y = row * canvas.height / this.gridPreset.row;
              
    
                            if ((mouseX && mouseY) && (mouseX >= x && mouseX <= (x + tileWidth) 
                                                            && (mouseY >= y && mouseY <= (y + tileHeight)))) {
                                this.selectedTileIndex = col + (row * this.gridPreset.column);
                                this.newBlock = this.blocks[this.selectedTileIndex];        
                            }
                        }
                    }
                } else if (this.currentPaintToolMode == this.paintToolMode.Hand) {                
                    this.newBlock.points.push({x: mouseX, y: mouseY});     
                }
            }
        },
        // paint methods - end
        createBlockFloors(index) {
            this.blocks[index].floors = [];
            for (var i = 0; i < this.totalFloor; i++) {
                let floor = {
                    name: '',
                    imageBase64: null,
                    tiles: [],
                }
                if (i == 0) {
                    floor.name = this.selectedFirstFloorType;
                } else if (this.selectedFirstFloorType == this.FirstFloorType.Ground) {
                    floor.name = `${i}`;
                } else if (this.selectedFirstFloorType == this.FirstFloorType.FloorOne) {
                    floor.name = `${i + 1}`;
                }
                this.blocks[index].floors.push(floor);
            }
            if (this.totalBasementFloor > 0) {
                for (var i = 1; i <= this.totalBasementFloor; i++) {
                    let floor = {
                        name: `B${i}`,
                        imageBase64: null,
                        tiles: [],
                    }
                    this.blocks[index].floors.unshift(floor); // add to the head of list
                }
            }
            this.blocks[index].floors = this.blocks[index].floors.slice().reverse();
        }
    },
    watch: {
        // 'image': function() {
        //     this.$refs.myCanvas.style.height = this.$refs.myImage.naturalHeight;
        //     this.$refs.myCanvas.style.widht = this.$refs.myImage.naturalWidth;
        // }
        // file: function() {
            // let canvas = this.$refs.myCanvas;
            // let canvasContext = canvas.getContext('2d');
            // this.background = new Image();
            // this.background.src = this.floorPlanImageFile.base64;
            // this.background.onload = () => {
            //     canvasContext.drawImage(this.background, 0, 0);
            // }
        // },
        selectedGridPreset: function() {
            if (this.selectedGridPreset) {
                if (this.selectedGridPreset == 'custom') {
                    this.gridPreset = {
                        column : this.customColumns,
                        row: this.customRows,
                    };
                } else {
                    this.gridPreset = this.selectedGridPreset;
                }
                this.clearCanvas();
                this.blocks = [];    
                this.paintCanvas(null, null);
            }
        },
        currentPaintToolMode: function() {
            this.clearCanvas();
            if (this.currentPaintToolMode == this.paintToolMode.Preset && this.selectedGridPreset) {
                this.paintCanvas(null, null);
            } 
            // else if (this.currentPaintToolMode == this.paintToolMode.Hand && this.newBlock.points.length > 0) {
            //     this.drawPoints();
            // }
        },
        'newBlock.name': function() {
            if (this.selectedTileIndex >= 0) {
                this.blocks[this.selectedTileIndex].name = this.newBlock.name;
            }
            this.drawPoints();
        },
        customColumns: function() {
            this.gridPreset = {
                column: this.customColumns,
                row: this.customRows,
            }
            this.clearCanvas();
            this.blocks = [];    
            this.paintCanvas(null, null);
        },
        customRows: function() {
            this.gridPreset = {
                column: this.customColumns,
                row: this.customRows,
            }
            this.clearCanvas();
            this.blocks = [];    
            this.paintCanvas(null, null);
        },
        totalFloor: function() {
            this.createBlockFloors(this.createFloorCurrentBlock);
        },
        totalBasementFloor: function() {
            this.createBlockFloors(this.createFloorCurrentBlock);
        },
        selectedFirstFloorType: function() {
            this.createBlockFloors(this.createFloorCurrentBlock);
        },
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
