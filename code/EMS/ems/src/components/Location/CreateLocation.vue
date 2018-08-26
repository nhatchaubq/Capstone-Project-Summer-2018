<template>
    <div class="form">
      <div class="form-title">                
        <div class="form-title-start">
          Add New Location <span style="font-size: 1rem;" class="warning-text" v-if="quickCreatePosition">* Quickly create position is enabled</span>
        </div>
        <div class="form-title-end">                              
          <button class="button" style="margin-right: .5rem" :style="currentStep > 0 && !quickCreatePosition ? 'margin-right: 3rem' : ''" v-on:click="$router.push('/location')">Cancel</button>
          <simplert :useRadius="true" :icon="true" ref="simplert"></simplert>
          <button style="margin-right: .5rem; background: #eeeeee; color: black" v-if="currentStep > 0 && !quickCreatePosition" id="" class="button" v-on:click="() => {
            --currentStep;
          }">Back</button>
          <button class="button" :class="quickCreatePosition ? 'is-info': 'is-primary'"
          :style="(currentStep == Steps.CreateLocation 
                    && (CreateLocationErrors.ErrorLocationName
                        || CreateLocationErrors.ErrorLocationAddress))
                  || (currentStep == Steps.CreateBlocks && !toCreateBlocks.length)
                  || (currentStep == Steps.CreateFloorsAndTiles && currentToCreateBlockIndex != -1) ? 'cursor: not-allowed; background: #8CACA9' : ''"
            v-on:click="() => {
            if (quickCreatePosition) {
              if (validateLocation()) {
                createLocation();
              }
            } else {
              switch (currentStep) {
                case Steps.CreateLocation: {
                  if (validateLocation()) {
                    ++currentStep;
                  }
                  break;
                }
                case Steps.CreateBlocks: {
                  if (toCreateBlocks.length) {
                    createNewBlockFlag = false;
                    CreateLocationErrors.ErrorBlockName = '';
                    newBlock = {
                      name: '',
                      description: '',
                      floors: [],
                      firstFloorType: 'Ground',
                      totalFloor: 1,
                      totalBasementFloor: 0,
                      tilePrefix: 'none',
                    };
                    ++currentStep;
                    currentToCreateBlockIndex = 0;
                  }
                  break;
                }
                case Steps.CreateFloorsAndTiles: {
                  if (currentToCreateBlockIndex == -1) {
                    createLocation();
                  }
                  break;
                }
              }
            }
          }">{{ nextButtonText }}<span v-show="sending"> <i class="fa fa-circle-o-notch fa-spin"></i></span></button>
        </div>           
      </div>
      <div class="form-content" >
        <!-- STEP: CREATE LOCATION - START -->
        <div v-if="currentStep == Steps.CreateLocation" style="display: grid; grid-template-columns: 50% 50%;">
          <!-- left grid -->
          <div>
            <div class="form-field" style="padding-top:1.5rem; padding-bottom: 0 !important;">
                <div class="form-field-title">
                    <strong>Location name (required)</strong>
                    <span class="error-text" v-if="CreateLocationErrors.ErrorLocationName"> {{ CreateLocationErrors.ErrorLocationName }}</span>
                </div>
                <div>
                    <input :style="CreateLocationErrors.ErrorLocationName ? 'border: 1px solid var(--danger-color)' : ''" v-model="newLocation.name" type="text" class="input" placeholder="Chung cư 4S Linh Đông" />
                </div>
            </div>
            <div class="form-field" style="padding-top: 0 !important; padding-bottom: 0 !important">
                <div class="form-field-title">
                    <strong>Address (required)</strong>
                    <span class="error-text" v-if="CreateLocationErrors.ErrorLocationAddress != ''"> {{ CreateLocationErrors.ErrorLocationAddress }}</span>
                </div>
                <div>                  
                    <div>                    
                      <label class="ggSearch" style="width: 100%">
                        <gmap-autocomplete  class="input"
                          :value="currentPlace ? currentPlace.formatted_address : null"
                          :style="CreateLocationErrors.ErrorLocationAddress ? 'border: 1px solid var(--danger-color)' : ''" placeholder="135 Yersin, phường Phú Cường, Thành phố Thủ Dầu Một, Bình Dương"
                          @place_changed="setPlace">
                        </gmap-autocomplete>
                        <!-- <button  id="clear-btn" v-if="currentPlace" v-on:click="() => {}">
                          <i class="material-icons">close</i>
                        </button> -->
                        <!-- <button @click="addMarker" class="btn" style="position: relative; bottom: 8px;">Check</button> -->
                      </label>                   
                    </div>                                 
                </div>
            </div>
            <div class="form-field" style="padding-top: 0;">
              <label class="checkbox" style="font-style: italic; font-weight: 500;">
                <input class="checkbox" type="checkbox" v-model="quickCreatePosition" />
                Quickly create position for this location with Block 1, Floor G and Tile 1.
              </label>
            </div>
            <div class="form-field row" style="padding-left: 2rem !important; padding-top: 0; margin: 0">
              <div class="form-field-title" style="display: flex;">
                <strong>Team (optional)</strong>
              </div>
              <div class="select" style="margin-left: 1rem; width: 74%" >
                <select v-model="selectedTeam" style="width: 100%">
                  <option disabled=disabled :value="null"> -- Choose new team --</option>
                  <!-- <option :disabled="selectedTeams.length > 0" v- value="null">Not now</option> -->
                  <option v-bind:key='team.Id' v-for='team in teams' :value="team">{{team.Name}}</option>
                </select>
              </div>
                <div style="margin-top: 1rem; user-select: none;">
                  <span :key='team.Id' v-for="team in selectedTeams" style="margin-right: 0.3rem !important">
                    <label style="margin: 0! important;" class="lb-team">
                    {{team.Name}} <span style="font-size: 1rem; margin-left: .5rem;" class="delete" v-on:click="removeSelectedTeam(team)"></span>
                    </label>
                  </span>
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                  <strong>Description (optional)</strong>
                </div>
                <div>
                    <textarea class="input" v-model="newLocation.description" style="width: 100%; max-height: 7rem; min-height: 4rem; height: 4rem"></textarea>
                </div>
            </div>
          </div><!-- left grid -->
          <!-- right grid -->
          <div style="padding: 0 2.1rem 0 .5rem;">
            <gmap-map
              :center="marker?  marker : center"
              :zoom="12"
              style="margin-top: 2.8rem; width:100%; height: 20rem;"
              class="material-box material-shadow"
            >
              <gmap-marker
                v-if="marker"
                :position="marker"                
              ></gmap-marker>
            </gmap-map> 
          </div><!-- right grid -->
        </div> <!-- STEP: CREATE LOCATION - END -->
        <!-- STEP: CREATE BLOCKS - START -->
        <div v-if="currentStep == Steps.CreateBlocks">
          <div class="form-field" style="margin-top: .8rem; margin-bottom: 0;">
            <div class="form-field-title">
                Creating blocks for location {{ newLocation.name }}
            </div>
            <div style="margin-top: 1rem;">
              <div style="margin-bottom: 1rem;" :key="'toCreateBlock' + index" v-for="(block, index) in toCreateBlocks">
                <span>- Block
                  <span v-if="!editingBlockIndexes.includes(index)"> {{ block.name }}</span>
                  <input v-if="editingBlockIndexes.includes(index)" class="input" type="text" style="position: relative; top: -.5rem; width: 10%; text-align: right" v-model="block.name">
                </span>
                <span style="margin-left: .6rem; user-select: none;">
                  <a @click="() => {
                    if (editingBlockIndexes.includes(index)) { 
                      editingBlockIndexes = editingBlockIndexes.filter(i => i != index);
                    } else {
                      editingBlockIndexes.push(index);
                    }
                  }">{{ editingBlockIndexes.includes(index) ? 'done' : 'edit' }}</a> | 
                  <a @click="() => {
                    toCreateBlocks.splice(index, 1);
                  }">remove</a>
                </span>
              </div>
            </div>
            <div v-if="!createNewBlockFlag" style="padding-top: 0; padding-bottom: 0; margin-bottom: 0;">
              <a @click="createNewBlockFlag = true"><i class="fa fa-plus-circle"></i> Add new block</a>
            </div>
          </div>
          <div v-if="createNewBlockFlag">
            <div class="form-field" style="margin-bottom: 0;">
              <div class="form-field-title">
                  Block name (required)
                  <span class="error-text" v-if="CreateLocationErrors.ErrorBlockName"> {{ CreateLocationErrors.ErrorBlockName }}</span>
              </div>
              <div class="form-field-input" style="display: flex !important; margin-top: 0; padding-top: 0;">
                <input v-model.trim="newBlock.name" type="text"
                      :style="CreateLocationErrors.ErrorBlockName ? 'border: 1px solid var(--danger-color)' : ''"
                      class="input" required placeholder="A, B, C" style="width: 40%;" v-on:input="() => {
                        if (!newBlock.name) {
                          CreateLocationErrors.ErrorBlockName = ErrorStrings.NoBlockName;
                        } else if (newBlock.name.length > 50) {
                          CreateLocationErrors.ErrorBlockName = ErrorStrings.InvalidBlockNameLength;
                        } else {
                          let duplicateName = false;
                          for (let i = 0; i < toCreateBlocks.length; i++) {
                            const block = toCreateBlocks[i];
                            if (block.name.toLowerCase() == newBlock.name.toLowerCase()) {
                              duplicateName = true;
                              break;
                            }
                          }
                          if (duplicateName) {
                            CreateLocationErrors.ErrorBlockName = ErrorStrings.DuplicateBlockName;
                          } else {
                            CreateLocationErrors.ErrorBlockName = '';
                          }
                        }
                      }">
              </div>
            </div>
            <div class="form-field">
              <a :style="CreateLocationErrors.ErrorBlockName ? 'color: var(--shadow) !important; cursor: not-allowed;' : ''"
                v-on:click="createBlock()"><i class="fa fa-check-circle"></i> Create block</a>
              <a style="margin-left: 1.5rem; font-weight: 400 !important;" @click="() => {
                CreateLocationErrors.ErrorBlockName = '';
                newBlock = {
                  name: '',
                  description: '',
                  floors: [],
                  firstFloorType: 'Ground',
                  totalFloor: 1,
                  totalBasementFloor: 0,
                  tilePrefix: 'none',
                };
                createNewBlockFlag = false;
              }"><i class="fa fa-ban"></i> Cancel</a>
            </div>
          </div>
        </div> <!-- naming and describe block -->
        <!-- STEP: CREATE BLOCKS - END -->
        <!-- STEP: CREATE FLOORS AND TILES - START -->
        <div v-if="currentStep == Steps.CreateFloorsAndTiles">
            <div v-if="currentToCreateBlockIndex >= 0" class="row" style="padding: 0 !important; margin-right: 0;">
              <!-- define floor info -->
              <div class="col-6">
                  <div class="form-field" style="padding-bottom: 0; margin-bottom: 0;">
                    <button class="button"
                      style="margin-right: .5rem;"
                      :style="{background: currentToCreateBlockIndex == index ? '#424242' : '',
                                            color: currentToCreateBlockIndex == index ? 'white' : 'black', }"
                      :key="'createdblockfloor' + index" v-for="(block, index) of toCreateBlocks">
                      Block {{ block.name }}
                    </button>
                  </div>
                  <div class="form-field" style="padding-bottom: 0; margin-bottom: 0;">
                      <!-- creating block floor -->
                      <div class="form-field-title" v-if="!editingFloor">
                          Please provide some information that help create floors for Block {{ toCreateBlocks[currentToCreateBlockIndex].name }}.                        
                      </div>
                      <!-- editing block floor -->
                      <div class="form-field-title" v-else>
                          Editing floors information for Block {{ toCreateBlocks[currentToCreateBlockIndex].name }}.                        
                      </div>
                  </div>
                  <div class="form-field">
                    <div class="form-field-title">
                        <span style="position: relative; top: .5rem">Block {{ toCreateBlocks[currentToCreateBlockIndex].name }} has </span>
                          <span>
                            <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="1" max="300" step="1" v-model.number="toCreateBlocks[currentToCreateBlockIndex].totalFloor" v-on:input="() => {
                              currentToCreateFloorIndex = -1;
                              currentToCreateTileIndex = -1;
                              if (!toCreateBlocks[currentToCreateBlockIndex].totalFloor || toCreateBlocks[currentToCreateBlockIndex].totalFloor < 0) {
                                toCreateBlocks[currentToCreateBlockIndex].totalFloor = 1
                              } else if (toCreateBlocks[currentToCreateBlockIndex].totalFloor > 300) {
                                toCreateBlocks[currentToCreateBlockIndex].totalFloor = 300;
                              }
                              toCreateBlocks[currentToCreateBlockIndex].totalFloor = parseInt(toCreateBlocks[currentToCreateBlockIndex].totalFloor);
                              createFloors(currentToCreateBlockIndex);
                            }">
                          </span>
                        <span style="position: relative; top: .5rem">floor<span v-if="toCreateBlocks[currentToCreateBlockIndex].totalFloor > 1">s</span>,</span>
                        <span style="position: relative; top: .5rem"> and has </span>
                          <span>
                            <input class="input" style="width: 4rem; text-align: right; margin: 0 .5rem" type="number" min="0" v-model.number="toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor" v-on:input="() => {
                              currentToCreateFloorIndex = -1;
                              currentToCreateTileIndex = -1;
                              if (!toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor || toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor < 0) {
                                toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor = 0;
                              } else if (toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor > 300) {
                                toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor = 300;
                              }
                              toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor = parseInt(toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor);
                              createBasementFloors(currentToCreateBlockIndex);
                            }">
                          </span>
                        <span style="position: relative; top: .5rem"> basement floor<span v-if="toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor > 1">s</span>.</span>
                    </div>
                  </div>
                  <div class="form-field" style="margin-bottom: 1.5rem; padding-bottom: 0">
                      <div class="form-field-title">
                          What would you call the first floor of Block {{ toCreateBlocks[currentToCreateBlockIndex].name }} ?  
                      </div>
                      <div class="form-field-input" style="margin: .5rem 0 !important">
                          <label class="radio" v-on:click="() => {
                              const block = toCreateBlocks[currentToCreateBlockIndex];
                              block.firstFloorType = 'Ground';
                              const floors = block.floors;
                              floors.reverse();
                              // floors[floors.totalBasementFloor] is the ground floor
                              floors[block.totalBasementFloor].name = 'Ground';
                              for (let i = block.totalBasementFloor + 1, number = 1; i < floors.length; i++, number++) {
                                floors[i].name = `${number}`;
                              }
                              floors.reverse();
                              changeNameAllTiles(currentToCreateBlockIndex);
                            }">
                              <input type="radio" name="firstFloorType" :checked="toCreateBlocks[currentToCreateBlockIndex].firstFloorType == 'Ground'">
                              Ground
                          </label>
                          <label class="radio" v-on:click="() => {
                              const block = toCreateBlocks[currentToCreateBlockIndex];
                              block.firstFloorType = 'FloorOne';
                              const floors = block.floors;
                              floors.reverse();
                              // floors[floors.totalBasementFloor] is the ground floor
                              for (let i = block.totalBasementFloor, number = 1; i < floors.length; i++, number++) {
                                floors[i].name = `${number}`;
                              }
                              floors.reverse();
                              changeNameAllTiles(currentToCreateBlockIndex);
                            }">
                              <input type="radio" name="firstFloorType" :checked="toCreateBlocks[currentToCreateBlockIndex].firstFloorType == 'FloorOne'">
                              Floor 1
                          </label>
                      </div>
                  </div>
                  <!-- define tile name style -->
                  <div class="form-field" style="padding-top: 0; margin-top: 0">
                      <div class="form-field-title">
                          Define your room name style <span style="font-style: italic">(not affect tiles of basement floors)</span>
                      </div>
                      <div style="margin: .5rem 0 !important" class="row form-field-input">
                          <div>
                              <span style="margin-right: 1rem;">Prefix:</span>
                              <label class="radio">
                                  <input :checked="toCreateBlocks[currentToCreateBlockIndex].tilePrefix == 'none'" class="radio" type="radio"
                                  v-on:click="() => {
                                    toCreateBlocks[currentToCreateBlockIndex].tilePrefix = 'none';
                                    changeNameAllTiles(currentToCreateBlockIndex);
                                  }">
                                  None
                              </label>
                              <label class="radio">
                                <input :checked="toCreateBlocks[currentToCreateBlockIndex].tilePrefix == 'floororder'" class="radio" type="radio"
                                  v-on:click="() => {
                                    toCreateBlocks[currentToCreateBlockIndex].tilePrefix = 'floororder';
                                    changeNameAllTiles(currentToCreateBlockIndex);
                                  }">
                                  Floor number
                              </label>
                          </div>
                      </div>
                  </div> <!-- define tile name style -->
                  <!-- tile or room -->


                  <!-- finish / save changes button -->
                  <div class="form-field">
                      <!-- click this <a> to create/edit floors info of a block -->
                      <a v-on:click="() => {
                          if (!editingFloor) {
                              ++currentToCreateBlockIndex;
                              // at the end of block list, no need move to next block to create more floor
                              if (currentToCreateBlockIndex >= toCreateBlocks.length) {
                                  currentToCreateBlockIndex = -1; // currentToCreateBlockIndex = -1 to display the review
                              }
                          } else {
                              currentToCreateBlockIndex = -1;
                              editingFloor = false;
                          }
                      }"><i class="fa fa-check-circle"></i> {{ editingFloor ? 'Save changes ' : 'Finish creating floors for '}} Block {{ toCreateBlocks[currentToCreateBlockIndex].name }}</a>
                  </div> <!-- finish / save changes button -->
              </div> <!-- define floor info -->
              <!-- display floors visually -->
              <div class="col-6" style="padding-left: 0; padding-right: 0">
                  <div class="form-field" style="padding-right: 0">
                      <div class="form-field-title" style="margin: .5rem 0 !important">
                          Please click on visual floors below to setup tiles for each floor.
                      </div>
                      <div class="row" style="margin: .5rem 0 !important">
                          <!-- display floors -->
                          <div style="width: 15%;">
                              <div :key="'blockFloors' + index" v-for="(floor, index) in toCreateBlocks[currentToCreateBlockIndex].floors" style="padding-bottom: .3rem">
                                  <!-- button to select a floor -->
                                  <button class="button material-shadow" 
                                          :class="{'btn-primary': (index == toCreateBlocks[currentToCreateBlockIndex].floors.length - toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor - 1),
                                                  'is-active-block': currentToCreateFloorIndex == index,
                                                  }" 
                                          style="text-align: center; width: 100%;" 
                                          :style="((index == toCreateBlocks[currentToCreateBlockIndex].floors.length - toCreateBlocks[currentToCreateBlockIndex].totalBasementFloor - 1) 
                                                      && currentToCreateFloorIndex == index) ? 
                                                      'background: var(--darken-primary-color) !important; border: none !important' : ''"
                                          v-on:click="() => {
                                              currentToCreateFloorIndex = index;
                                              currentToCreateTileIndex = -1;
                                              if (toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].tiles.length == 0) {
                                                  createTiles();
                                              }
                                              //let floor = toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex];

                                          }">
                                      {{ floor.name }}
                                  </button> <!-- button to select a floor -->
                              </div>
                          </div><!-- display floors -->
                          <!-- after selected a floor -->
                          <div v-if="currentToCreateFloorIndex >= 0" style="width: 75%; margin-left: 5%; padding: 0 !important;">
                              <div style="margin: 0 !important;" class="row">
                                  <span style="position: relative; top: .5rem">Floor {{ toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].name }} has:</span>
                                  <input style="margin: 0 .5rem; text-align: right;" class="input col-2" type="number" min='1' max="1000" step="1" v-model.number="toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].totalTiles" v-on:input="() => {
                                    if (!toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].totalTiles || toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].totalTiles < 0) {
                                      toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].totalTiles = 1;
                                    } else if (toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].totalTiles > 1000) {
                                      toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].totalTiles = 1000;
                                    }
                                    toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].totalTiles = parseInt(toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].totalTiles);
                                    createTiles();
                                  }">
                                  <span style="position: relative; top: .5rem"> tile<span v-if="toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].totalTiles > 1">s</span></span>
                              </div>
                              <!-- <div v-if="toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].tiles.length > 0">
                                  <span><strong>Click on the rooms below to edit its name.</strong></span>
                              </div> -->
                              <div :key="'tile' + index" v-for="(tile, index) in toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].tiles">
                                  <a v-if="index != currentToCreateTileIndex" v-on:click="() => {
                                    currentToCreateTileIndex = index;
                                  }">Tile {{tile.name}}</a>
                                  <div v-if="index == currentToCreateTileIndex">
                                      <input class="input" style="width: 15%; text-align: right; margin-right: 1rem" type="text" 
                                          v-model="toCreateBlocks[currentToCreateBlockIndex].floors[currentToCreateFloorIndex].tiles[index].name">
                                      <a style="position: relative; top: .5rem;" v-on:click="currentToCreateTileIndex = -1;">
                                          <i class="fa fa-check-circle"></i> Save changes
                                      </a>
                                  </div>
                              </div>
                          </div> 
                          <!-- after selected a floor -->
                      </div>
                  </div>
              </div> <!-- display floors visually -->
          </div>
          <!-- else, this happens after created floors for all the newLocation.blocks or save changes of an editing block -->
          <div v-else>
              <div class="form-field" style="margin-top: 1.5rem;">
                  <div class="form-field-title">
                      Please recheck the floors information of <span v-if="toCreateBlocks.length == 1">this block</span><span v-if="toCreateBlocks.length > 1">these blocks</span> (click on a block to edit floor information):
                  </div>
                  <div :key="'makeBlockFloor' + block.id" v-for="block in toCreateBlocks">
                      <div style="padding-left: 1rem; margin-top: .5rem">
                          <!-- click the <a> below to edit selected block -->
                          <span>- <a v-on:click="() => {
                                      currentToCreateBlockIndex = toCreateBlocks.indexOf(block);
                                      currentToCreateFloorIndex = -1;
                                      currentToCreateTileIndex = -1;
                                      editingFloor = true;
                                  }">Block {{ block.name }}</a> has <strong>{{ block.totalFloor }} floor<span v-if="block.totalFloor > 1">s</span></strong>
                                  <span>, <strong>{{ block.totalBasementFloor > 0 ? block.totalBasementFloor : 'no' }} basement floor<span v-if="block.totalBasementFloor > 1">s</span></strong></span>
                                  <span>, and start with <strong>floor {{ block.firstFloorType == 'Ground' ? 'Ground' : '1' }}</strong>.</span>
                          </span>
                      </div>
                  </div>
              </div>
            </div> <!-- else -->
        </div> <!-- STEP: CREATE FLOORS AND TILES - START -->
      </div>    
    </div>        
</template>

<script>
import Server from "@/config/config.js";
import { gmapApi } from "vue2-google-maps";
import Simplert from "vue2-simplert";
import Utils from "@/utils.js";

export default {
  components: {
    Simplert
  },
  computed: {
    google: gmapApi,
    nextButtonText() {
      let value = "";
      if (this.quickCreatePosition) {
        value = 'Create New Location';
      } else {
        if (this.currentStep == this.Steps.CreateLocation) {
          value = 'Next: Create Blocks';
        } else if (this.currentStep == this.Steps.CreateBlocks) {
          value = 'Next: Create Floors and Tiles';
        } else if (this.currentStep == this.Steps.CreateFloorsAndTiles) {
          value = 'Create New Location';
        }
      }
      return value;
    }
  },
  data() {
    return {
      teams: [],
      selectedTeam: null,
      tempTeams: [],
      allLocations: [],
      selectedTeams: [],
      newLocation: {
        name: "",
        address: "",
        description: "",
        longtitude: "",
        latitude: "",
        idActive: null
      },

      center: { lat: 45.508, lng: -73.587 },
      marker: null,
      place: null,
      currentPlace: null,
      CreateLocationErrors: {
        ErrorLocationName: "",
        ErrorLocationAddress: "",
        ErrorBlockName: '',
        DuplicateBlockName: '',
        ErrorFloorName: '',
        ErrorTileName: ''
      },
      ErrorStrings: {
        NoName: "You must provide location name",
        InvalidLocationNameLength: "Use 6 to 250 characters for location name",
        NoAddress: "You must provide location address",
        DuplicateAddress: "Both name and address already exists.",
        InvalidLocationAddressLength: "Use 6 to 250 characters for location address",
        DuplicateName: "Both name and address already exists.",
        NoBlockName: 'You must provide block name',
        InvalidBlockNameLength: 'Use 50 or fewer for block name',
        DuplicateBlockName: 'Block name is duplicated',
        NoFloorName: 'You must provide floor name',
        InvalidFloorNameLength: 'Use 50 or fewer for floor name',
        DuplicateFloorName: 'Floor name is duplicated',
        NoTileName: 'You must provide tile name',
        InvalidTilekNameLength: 'Use 50 or fewer for tile name',
        DuplicateTileName: 'Tile name is duplicated',
      },
      form: {
        Name: "",
        Address: ""
      },
      duplicate: false,
      //chaubqn - start
      quickCreatePosition: false,
      Steps: {
        CreateLocation: 0,
        CreateBlocks: 1,
        CreateFloorsAndTiles: 2
      },
      currentStep: 0,
      createNewBlockFlag: false,
      toCreateBlocks: [],
      editingBlockIndexes: [],
      duplicateBlockIndexes: [],
      currentToCreateBlockIndex: - 1,
      newBlock: {
        name: '',
        description: '',
        floors: [],
        firstFloorType: 'Ground',
        totalFloor: 1,
        totalBasementFloor: 0,
        tilePrefix: 'none',
      },
      currentToCreateFloorIndex: - 1,
      editingFloor: false,
      currentToCreateTileIndex: - 1,

      sending: false,
      //chaubqn - end
    };
  },
  mounted() {
    this.geolocate();
  },
  created() {
    this.axios
      .get(Server.TEAM_API_PATH + "/getAllTeam")
      .then(response => {
        let data = response.data;
        data.forEach(team => {
          if (team.Status) this.teams.push(team);
        });
      })
      .catch(error => {
        console.log(error);
      });
    this.getAllLocations();
  },

  methods: {
    validateLocation() {
      this.duplicate = false;
      if (!this.newLocation.name) {
        this.CreateLocationErrors.ErrorLocationName = this.ErrorStrings.NoName;
      } else if (this.newLocation.name.length < 6 || this.newLocation.name.length > 100) {
        this.CreateLocationErrors.ErrorLocationName = this.ErrorStrings.InvalidLocationNameLength;
      }
      if (!this.currentPlace || !this.newLocation.address) {
        this.CreateLocationErrors.ErrorLocationAddress = this.ErrorStrings.NoAddress;
      } else if (this.newLocation.address.length < 6 || this.newLocation.address.length > 250) {
        this.CreateLocationErrors.ErrorLocationAddress = this.ErrorStrings.InvalidLocationAddressLength;
      }
      if (this.currentPlace) {
        for (const location of this.allLocations) {
          if (
            this.newLocation.name.trim().toUpperCase() == location.Name.toUpperCase() &&
            parseFloat(this.currentPlace.geometry.location.lng()).toFixed(6) ==
              parseFloat(location.Longitude).toFixed(6) &&
            parseFloat(this.currentPlace.geometry.location.lat()).toFixed(6) ==
              parseFloat(location.Latitude).toFixed(6)
          ) {
            this.duplicate = true;
            break;
          }
        }
      }
      if (this.duplicate) {
        this.CreateLocationErrors.ErrorLocationName = this.ErrorStrings.DuplicateName;
        this.CreateLocationErrors.ErrorLocationAddress = this.ErrorStrings.DuplicateAddress;
      }
      return !this.CreateLocationErrors.ErrorLocationName 
          && !this.CreateLocationErrors.ErrorLocationAddress;
    },
    validateBlocks() {

    },
    async createLocation() {
      this.sending = true;
      await this.axios
        .post(Server.LOCATION_CREATE_API_PATH, {
          newLocation: {
            name: this.newLocation.name.trim(),
            address: this.currentPlace.formatted_address,
            description: this.newLocation.description.trim(),
            longtitude: this.currentPlace.geometry.location.lng(),
            latitude: this.currentPlace.geometry.location.lat(),
            isActive: 1
          }
        })
        .then(async res => {
          // alert(this.selectedTeams.length);
          if (this.selectedTeams.length > 0) {
            if (res.data.NewLocationId) {
              this.selectedTeams.forEach(async team => {
                await this.axios.post(Server.TEAM_LOCATION_CREATE_API_PATH, {
                  locationId: res.data.NewLocationId,
                  teamId: team.Id
                });
              });
            }
          }
          // create position
          if (this.quickCreatePosition) {
            this.toCreateBlocks = [{
              name: '1',
              totalFloor: 1,
              totalBasementFloor: 0,
              description: null,
              floors: [{
                name: 'G',
                tiles: [{name: '1'}]
              }]
            }]
          }
          await this.createPostion(res.data.NewLocationId);
          this.sending = false;
          let obj = {
            title: "Location created successfully!",
            type: "success"
          };
          this.$refs.simplert.openSimplert(obj);
          await Utils.sleep(1500);
          this.$router.push("/location");
        })
        .catch(error => {
          console.log(error);
        });
    },
    getAllLocations() {
      let url = "";
      url = "http://localhost:3000/api/location/";
      this.axios
        .get(url)
        .then(response => {
          let data = response.data;
          data.forEach(location => {
            this.allLocations.push(location);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    removeSelectedTeam(tmpTeam) {
      this.selectedTeams = this.selectedTeams.filter(
        team => team.Id != tmpTeam.Id
      );
      // this.teams = this.tempTeams;
      this.teams = this.tempTeams.filter(
        team => !this.selectedTeams.includes(team)
      );

      if (this.selectedTeams.length == 0) {
        this.teams = this.tempTeams;
      }
    },
    setPlace(place) {
      this.currentPlace = place;
      // alert(JSON.stringify(this.currentPlace));
    },    
    geolocate() {
      navigator.geolocation.getCurrentPosition(position => {
        this.center = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
      });
    },
    createBlock() {
      if (!this.newBlock.name) {
        this.CreateLocationErrors.ErrorBlockName = this.ErrorStrings.NoBlockName;
      }
      if (!this.CreateLocationErrors.ErrorBlockName) {
        let tempBlock = JSON.stringify(this.newBlock);
        tempBlock = JSON.parse(tempBlock);
        this.toCreateBlocks.push(tempBlock);
        this.newBlock = {
          name: '',
          description: '',
          floors: [],
          firstFloorType: 'Ground',
          totalFloor: 1,
          totalBasementFloor: 0,
          tilePrefix: 'none',
        };
        this.createFloors(this.toCreateBlocks.length - 1);
        this.createNewBlockFlag = false;
      }
    },
    createFloors(index) {
      // block.totalFloor is new total floor, count from floor ground, this value is binding in the input
      // floors.length - block.totalBasementFloor is current total floor, 
      // floors.length holds number of floors (including floors from the floor ground and basement floors)
      const block = this.toCreateBlocks[index];
      const floors = block.floors;
      floors.reverse();
      const newTotalFloor = block.totalFloor;
      const newTotalBasementFloor = block.totalBasementFloor;
      const currentTotalFloor = floors.length - newTotalBasementFloor;
      if (newTotalFloor > currentTotalFloor) {        
        for (let i = currentTotalFloor; newTotalFloor > floors.length - newTotalBasementFloor; i++) {
          const floor = {
            name: "",
            tiles: [{name: '1'}],
            totalTiles: 1,
          };
          if (!floors.length) {
            floor.name = block.firstFloorType == 'Ground' ? 'Ground' : '1';
          } else if (block.firstFloorType == 'Ground') {
            floor.name = `${i}`;
          } else if (block.firstFloorType == 'FloorOne') {
            floor.name = `${i + 1}`;
          }
          if (block.firstFloorType != 'Ground' && i != newTotalBasementFloor) {
            let prefix = "";
            switch (block.tilePrefix) {
              case "none": {
                prefix = "";
                break;
              }
              case "floororder": {
                prefix = floor.name;
                break;
              }
            }
            floor.tiles[0].name = `${prefix}${block.tilePrefix == "floororder" ? '0' : '' }1`;
          }
          floors.push(floor);
        }
      } else if (newTotalFloor < currentTotalFloor) {
        while (newTotalFloor < (floors.length - newTotalBasementFloor)) {
          floors.pop();
        }
      }      
      floors.reverse();
    },
    createBasementFloors(index) {
      // block.totalBasementFloor is new total basement floors, count from floor ground, this value is binding in the input
      // floors.length - block.totalFloor is current total basement floors, 
      // floors.length holds number of floors (including floors from the floor ground and basement floors)
      const block = this.toCreateBlocks[index];
      const floors = block.floors;      
      floors.reverse();
      const newTotalFloor = block.totalFloor;
      const newTotalBasementFloor = block.totalBasementFloor;
      const currentTotalBasementFloor = floors.length - newTotalFloor;
      if (newTotalBasementFloor > currentTotalBasementFloor) {
        for (let i = currentTotalBasementFloor + 1; newTotalBasementFloor > (floors.length - newTotalFloor); i++) {
          const floor = {
            name: `B${i}`,
            tiles: [{name: '1'}],
            totalTiles: 1,
          };
          floors.unshift(floor); // add to the head of list
        }
      } else if (newTotalBasementFloor < currentTotalBasementFloor) {
        while (newTotalBasementFloor < (floors.length - newTotalFloor)) {
          floors.shift();
        }
      }      
      floors.reverse();
    },
    createTiles() { // dont know why, but in this method the floor list is reversed
      const block = this.toCreateBlocks[this.currentToCreateBlockIndex];
      const floors = block.floors;
      const floor = floors[this.currentToCreateFloorIndex];
      // alert(this.currentToCreateFloorIndex + ' floor ' + floor.name + ' floorGroundIndex ' + (floors.length - block.totalBasementFloor - 1));
      if (!floor.tiles.length || (floor.totalTiles > floor.tiles.length)) {
        const floorGroundIndex = floors.length - block.totalBasementFloor - 1;
        let prefix = "";        
        switch (block.tilePrefix) {
          case "none": {
            prefix = "";
            break;
          }
          case "floororder": {
            prefix = floor.name;
            break;
          }
        }
        while (floor.tiles.length != floor.totalTiles) {
          const newTile = {
            name: `${floor.tiles.length + 1}`
          };
          if ((block.firstFloorType == 'FloorOne' && this.currentToCreateFloorIndex <= floorGroundIndex) 
              || (block.firstFloorType == 'Ground' && this.currentToCreateFloorIndex < floorGroundIndex)) {
                  newTile.name = `${prefix}${(floor.tiles.length + 1 < 10 && block.tilePrefix == "floororder") ? '0' : '' }` + newTile.name;
          }
          floor.tiles.push(newTile);
        }
      } else if (floor.totalTiles < floor.tiles.length) {
        while (floor.tiles.length != floor.totalTiles) {
          floor.tiles.pop();
        }
      }
      floor.totalTiles = floor.tiles.length;
    },
    changeNameAllTiles(blockIndex) {
      const block = this.toCreateBlocks[blockIndex];
      const floors = block.floors;      
      floors.reverse();
      // block.totalBasementFloor is floor ground
      const floorGroundIndex = block.totalBasementFloor;
      for (let i = floorGroundIndex; i < floors.length; i++) {
        if (i >= floorGroundIndex) {
          const floor = floors[i];
          let prefix = "";
          switch (block.tilePrefix) {
            case "none": {
              prefix = "";
              break;
            }
            case "floororder": {
              prefix = floor.name;
              break;
            }
          }
          for (let j = 0; j < floor.tiles.length; j++) {
            floor.tiles[j].name = `${j + 1}`;
            if (block.tilePrefix == 'floororder'
                && (block.firstFloorType == 'FloorOne' && i >= floorGroundIndex) 
                    || (block.firstFloorType == 'Ground' && i > floorGroundIndex)) {
                        floor.tiles[j].name = `${prefix}${(j + 1 < 10 && block.tilePrefix == "floororder") ? '0' : '' }` + floor.tiles[j].name;
            }
          }
        }
      }
      floors.reverse();
    },
    async createPostion(locationId) {
      return new Promise(async (resolve, reject) => {
        let context = this;
        let blockApi = `${Server.SERVER_DEFAULT}/block`;
        let floorApi = `${Server.SERVER_DEFAULT}/floor`;
        let tileApi = `${Server.SERVER_DEFAULT}/tile`;
        let newBlockApi = `${blockApi}/${locationId}`;
        for (const block of this.toCreateBlocks) {
            await context.axios.post(newBlockApi, {
              blockName: block.name,
              totalFloor: block.totalFloor,
              totalBasementFloor: block.totalBasementFloor,
              description: block.description,
            }).then(async (blockRes) => {
              if (blockRes.status == 200 && blockRes.data.NewBlockId) {
                let newBlockId = blockRes.data.NewBlockId;
                let newFloorApi = `${floorApi}/${newBlockId}`;
                for (const floor of block.floors) {
                    await context.axios.post(newFloorApi, {
                      floorName: floor.name,
                      description: floor.description
                    }).then(async (floorRes) => {
                      if (floorRes.status == 200 && floorRes.data.NewFloorId) {
                        let newFloorId = floorRes.data.NewFloorId;
                        let newTileApi = `${tileApi}/${newFloorId}`;
                        for (const tile of floor.tiles) {
                          await context.axios.post(newTileApi, {
                            tileName: tile.name,
                            description: floor.description
                          }).catch(error => {
                            reject();
                            console.log(error);
                          });
                        }
                      }
                    }).catch(error => {
                      reject();
                      console.log(error);
                    });
                }
              } else {
                reject();
                alert("Error NewBlockId");
              }
            }).catch(error => {
              reject();
              console.log(error);
            });
        }
        resolve();
      });
    },
  },
  watch: {
    "newLocation.name": function() {
      if (this.newLocation.name) {
        if (!this.duplicate) {
          this.CreateLocationErrors.ErrorLocationName = "";
          this.CreateLocationErrors.ErrorLocationAddress = "";
        } else {
          this.CreateLocationErrors.ErrorLocationName = "";
        }
      }
    },
    selectedTeam: function() {
      if (this.selectedTeam) {
        if (this.selectedTeams.length == 0) {
          this.tempTeams = this.teams;
        }
        this.teams = this.teams.filter(team => team.Id != this.selectedTeam.Id);
        this.selectedTeams.push(this.selectedTeam);
        this.selectedTeam = null;
      }
    },
    currentPlace: function() {
      if (this.currentPlace) {
        this.newLocation.address = this.currentPlace.formatted_address;
        if (!this.duplicate) {
          this.CreateLocationErrors.ErrorLocationAddress = "";
          this.CreateLocationErrors.ErrorLocationName = "";
        } else if (this.newLocation.name.length >= 6 && this.newLocation.name.length <= 250) {
            this.CreateLocationErrors.ErrorLocationName = '';
        }
        const tmpMarker = {
          lat: this.currentPlace.geometry.location.lat(),
          lng: this.currentPlace.geometry.location.lng()
        };
        this.marker = tmpMarker;
        this.place = this.currentPlace;
        this.center = this.marker;
      }
      // if (this.currentPlace) {
      // }
    },
    quickCreatePosition: function() {
      if (!this.quickCreatePosition) {
        this.currentStep = 0;
      }
    }
  }
};
</script>

<style scoped>
a {
  font-weight: bold;
}
.form {
  background-color: white;
  padding: 0 !important;
  grid-template-columns: 20% 20% 60%;
}
.form-content {
  font-size: 0.9rem;
  position: fixed;
  max-height: 82.5%;
  width: 82%;
  overflow-y: auto;
  /* display: flex;
        flex-direction: column;  */
}

.form-field {
  /* margin-bottom: 5px; */
  width: 100%;
  padding: 1rem 2rem;
}

.form-title {
  display: grid;
  grid-template-columns: 65% 35%;
  border-bottom: 1px solid #e0e0e0;
  padding: .5rem 2rem;
}
.form-title-start {
  padding-top: 0.2rem;
  font-weight: bold;
  font-size: 20px;
  color: #616161;
}
.form-title-end {
  width: 100%;
  display: flex;
  justify-content: flex-end;
}
.form-input {
  padding-left: 50px;
  padding-right: 50px;
}
.form-field {
  margin-bottom: 1.5rem;
}

.form-field-title {
  font-weight: bold;
}

.lb-team {
  border: 1px solid #616161;
  border-radius: 5px;
  padding: .3rem;
}
</style>
