<template>
    <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Work Order
            </div>
            <div></div>
            <div class="form-title-end">
                <!-- <button id="btn-cancel" class="button" style="" v-on:click="cancel">Cancel</button> -->
                <button class="button" style="margin-right: .5rem" v-on:click="cancel()">Cancel</button>
                <!-- <button id="btn-add" class="button is-primary">Create Work Order</button> -->
                <button class="button is-primary" v-on:click="createWorkOrder()">Create Work Order</button>
            </div>
        </div>
        <div class="form-content">
            <div class="form-field is-horizonal">
                <div class="form-field-title">Category: </div>
                <label class="radio" :key="category.Id" v-for="(category, index) in categories" v-on:click="workOrderCategory = category.Id" style="margin-right: 1rem;">
                    <input required type="radio" name="category" :checked="index == 0">
                    {{ category.Name }}
                </label>
            </div>
            <div class="form-field is-horizonal">
                <div class="form-field-title" style="margin-right: 1rem">Priority:</div> 
                <label class="radio" :key="priority.Id" v-for="(priority, index) in priorities" v-on:click="workOrderPriority = priority.Id" style="margin-right: 1rem; user-select: none;">
                    <input type="radio" name="priority" :checked="index == 0" style="margin-right: .3rem;">
                    <span class="tag" style="color: white" :style="`background-color: ${priority.TagHexColor}`">{{ priority.Name }}</span>
                </label>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Title this Work Order (required)
                </div>
                <div class="form-field-input">
                    <input v-model="workOrderTitle" type="text" class="input" required placeholder="Công trình dự án Vinhomes">
                </div>
                {{ workOrderTitle }}
            </div>
            <div class="form-field">
                <div style="display: grid; grid-template-columns: 40% 5% 15% 15% 5%; grid-column-gap: 1rem;">
                    <div class="form-field-title">
                        Choose equipment(s) (required) (press <a class="btn-plus"><i class="fa fa-plus"></i></a> after select)
                    </div>
                    <div style="text-align: center">Quantity</div>
                    <div>From</div>
                    <div>To</div>
                    <div></div>
                </div>
                <div :key="equipment.Id" v-for="equipment in selectedEquipments" style="display: grid; grid-template-columns: 40% 5% 15% 15% 5%; grid-column-gap: 1rem; margin-bottom: 1rem;">
                    <div style="padding-left: 1rem; display: grid; grid-template-columns: 5rem auto; grid-column-gap: 1rem;">
                        <img style="width: 100%; height: 5rem;" :src="equipment.image" alt="">
                        <div style="">
                            {{ equipment.name }}
                        </div>
                    </div>
                    <div>
                        <input style="text-align: center" class="input" type="number" min="1" :max="equipment.availableQuantity" v-model="equipment.quantity">
                    </div>
                    <div>
                        <input type="date" class="input" v-model="equipment.fromDate">
                    </div>
                    <div>
                        <input type="date" class="input" v-model="equipment.toDate">
                    </div>
                    <div>
                        <a v-on:click="removeEquipment(equipment)">Delete</a>
                    </div>
                </div>
                <div style="display: grid; grid-template-columns: 40% 5% 15% 15% 5%; grid-column-gap: 1rem;">                
                    <div class="form-field-input">
                        <div style="width: 100%">
                            <model-select :options="equipmentOptions" placeholder="Select an equipment" v-model="selectedEquipment"></model-select>
                        </div>
                    </div>  
                    <div class="form-field-input">
                        <input style="text-align: center" type="number" :disabled="selectedEquipment.availableQuantity == 0" min="1" :max="selectedEquipment.availableQuantity" class="input" v-model="selectedEquipmentQuantity">
                    </div>
                    <div>
                        <input class="input" type="date" v-model="selectedEquipmentFromDate">
                    </div>
                    <div>
                        <input class="input" type="date" v-model="selectedEquipmentToDate">
                    </div>
                    <div>
                        <a v-on:click="addEquipment()" style="position: relative; top: .5rem;" class="btn-plus"><i class="fa fa-plus"></i></a>
                    </div>           

                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Choose a location for this work order (required)
                </div>
                <div class="form-field-input">
                    <model-select :options="locationOptions" v-model="selectedLocation" placeholder="Select a location" style="width: 40%"></model-select>
                </div>
            </div>
            <div class="form-field" v-if="selectedLocation.value">
                <div v-if="teamOptions.length > 0">
                    <div class="form-field-title">
                        Pick a team from the selected location (required)
                    </div>
                    <div class="form-field-input">
                        <model-select :options="teamOptions" v-model="selectedTeam" placeholder="Select a team" style="width: 40%"></model-select>
                    </div>
                </div>
                <div v-else-if="teamOptions.length == 0">
                    There is no team in {{ selectedLocation.text }}
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Describe this work order (optional)
                </div>
                <div class="form-field-input">
                    <textarea class="input" rows="5" v-model="workOrderDescription"></textarea>
                </div>
            </div>
            <!-- <div class="form-field">
                <div class="file is-boxed has-name">
                    <label class="file-label" style="width: 100% !important">
                        <input class="file-input" type="file" ref="fileInput" v-on:change="inputFileChange" multiple accept=".jpg, .jpeg, .png" />
                        <span class="file-cta">
                            <span class="file-icon">
                                <i class="fa fa-upload"></i>
                            </span>
                            <span class="file-label">
                                Choose images...
                            </span>
                        </span>

                        <div v-bind:key="file.name" v-for="file in files" style="width: 100% !important;">
                            {{ file.name }}
                            <div>
                                <img v-bind:src="getFilePath(file)"/>
                            </div>
                        </div>
                    </label>
                </div>
            </div> -->
        </div>
    </div>
</template>

<script>
import Server from '@/config/config.js';

import moment from 'moment';

import {ModelSelect} from 'vue-search-select';

export default {    
    components: {
        ModelSelect,
    },
    data() {
        return {
            workOrderTitle: '',
            workOrderDescription: '',
            workOrderPriority: -1,
            workOrderCategory: -1,
            selectedEquipmentQuantity: 1,
            selectedEquipmentFromDate: '',
            selectedEquipmentToDate: '',
            selectedEquipments: [],
            selectedLocation: {
                text: '',
                value: '',
            },
            selectedTeam: {
                text: '',
                value: '',
            },
            selectedEquipment: {
                text: '',
                value: '',
                image: '',
                availableQuantity: 0,
            },
            categories: [],
            priorities: [],
            equipmentOptions: [],
            locationOptions: [],
            teamOptions: [],
        }
    },
    created() {
        this.axios.get(Server.WORKORDER_CATEGORIES_API_PATH)
            .then((res) => {
                if (res.data) {
                    let data = res.data;
                    this.categories = data;
                    this.workOrderCategory = data[0].Id;
                }
            });
        this.axios.get(Server.EQUIPMENT_API_PATH)
            .then((res) => {
                if (res.data) {
                    let data = res.data;
                    data.forEach(element => {
                        let quantity = parseInt(element.Equipment.AvailableQuantity);
                        let option = {
                            text: `${element.Equipment.Name}, available: ${quantity} ${quantity > 1 ? 'units' : 'unit'}`,
                            value: element.Equipment.Id,
                            image: element.Equipment.Image,
                            availableQuantity: quantity,
                        };
                        this.equipmentOptions.push(option);
                    });
                }
            });
        this.axios.get(Server.WORKORDER_PRIORITIES_API_PATH)
            .then((res) => {
                if (res.data) {
                    this.priorities = res.data;
                    this.workOrderPriority = this.priorities[0].Id;
                }
            });
        this.axios.get(Server.LOCATION_API_PATH)
            .then((res) => {
                if (res.data) {
                    let data = res.data;
                    data.forEach(location => {
                        let option = {
                            value: location.Id,
                            text: `${location.Name} - ${location.Address}`,
                        };
                        this.locationOptions.push(option);
                    });
                }
            });
        this.selectedEquipmentFromDate = this.getToday();
        this.selectedEquipmentToDate = this.getToday();
    },
    methods: {
        cancel() {
            this.$router.push('/work_order');
        },
        inputFileChange() {
            this.files = this.$refs.fileInput.files;
        },
        getFilePath(file) {
            return window.URL.createObjectURL(file);
        },
        addEquipment() {
            if (this.selectedEquipment.value && this.selectedEquipment.availableQuantity > 0) {
                let index = this.selectedEquipments.findIndex(equipment => equipment.id == this.selectedEquipment.value);
                if (index < 0) {
                    let equipment = {
                        id: this.selectedEquipment.value,
                        name: this.selectedEquipment.text,
                        quantity: parseInt(this.selectedEquipmentQuantity),
                        image: this.selectedEquipment.image,
                        availableQuantity: parseInt(this.selectedEquipment.availableQuantity),
                        fromDate: this.selectedEquipmentFromDate,
                        toDate: this.selectedEquipmentToDate,
                    };
                    this.selectedEquipments.push(equipment);
                } else {
                    let currentQuantity = parseInt(this.selectedEquipments[index].quantity);
                    this.selectedEquipments[index].quantity = currentQuantity + parseInt(this.selectedEquipmentQuantity);
                }
    
                this.selectedEquipment = { text: '', value: '', image: '', availableQuantity: 0 };
                this.selectedEquipmentQuantity = 1;
                this.selectedEquipmentFromDate = this.getToday();
                this.selectedEquipmentToDate = this.getToday();
            }
        },
        removeEquipment(equipment) {
            this.selectedEquipments = this.selectedEquipments.filter(e => e.id != equipment.id);
        },
        getToday() {
            return moment().format('YYYY-MM-DD');
        },
        createWorkOrder() {
            let context = this;
            let teamLocationApi = `${Server.TEAM_LOCATION_API_PATH}/${this.selectedLocation.value}/${this.selectedTeam.value}`;
            this.axios.get(teamLocationApi)
                .then(function(res) {
                    if (res.data.Id) {
                        let result = res.data.Id;
                        let workOrderApi = Server.WORKORDER_API_PATH;
                        let authUser = JSON.parse(window.localStorage.getItem('user'));

                        context.axios.post(workOrderApi, {
                            name: context.workOrderTitle,
                            description: context.workOrderDescription,
                            requestUserId: authUser.Id,
                            createDate: new Date(),
                            priorityId: context.workOrderPriority,
                            statusId: 1,
                            categoryId: context.workOrderCategory,
                            teamLocationId: result,
                        }).then(function(res) {
                            if (res.data.NewWorkOrderId) {
                                let newWorkOrderId = res.data.NewWorkOrderId;
                                context.selectedEquipments.forEach(equipment => {
                                    for (var i = 0; i < equipment.quantity; i++) {
                                        // alert('loopin');
                                        context.axios.post(Server.WORKORDER_DETAIL_API_PATH, {
                                            workOrderId: newWorkOrderId, 
                                            equipmentItemId: equipment.id, 
                                            startDate: equipment.fromDate, 
                                            dueDate: equipment.toDate, 
                                            maintainceCost: null, 
                                            description: null
                                        })
                                            .then(function(res) {
                                                if ((i + 1) > equipment.quantity) {
                                                    context.$router.push('/work_order');
                                                }
                                            }).catch((error) => {
                                                alert(error)
                                            });
                                    }
                                });
                            } else {
                                alert('No new work order id returned')
                            }
                        }).catch((error) => {
                            alert("Create work order detail: Cannot create work order due to some errors happened in the server. Please contact the system administrator to investigate this situation!" + error)
                        });

                    }
                }).catch((error) => {
                        alert("Create work order: Cannot create work order due to some errors happened in the server. Please contact the system administrator to investigate this situation!" + error)
                });
        }
    },
    watch: {
        'selectedLocation': function() {
            this.teamOptions = [];
            this.selectedTeam = {
                text: '',
                value: '',
            };
            if (this.selectedLocation.value) {
                // alert('in 2')
                let url = `${Server.LOCATION_API_PATH}/${this.selectedLocation.value}/team`;
                this.axios.get(url)
                    .then((res) => {
                        if (res.data) {
                            let data = res.data;
                            data.forEach(element => {
                                let option = {
                                    value: element.Team.Id,
                                    text: element.Team.Name,
                                };
                                this.teamOptions.push(option);
                            });
                        }
                    });
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
        display: grid;
        grid-template-columns: 25% 40% 35%;
        border-bottom: 1px solid #e0e0e0;
        padding: 1rem 2rem;
    }

    .form-title-start{
        position: relative;
        top: 10px;
        font-weight: bold;
        font-size: 20px;
        color: #616161;
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
        margin-right: .6rem
    }

    #btn-add {
        background-color: var(--primary-color);
        color: white;
    }

    .form-content {
        font-size: .9rem;
        position: fixed;
        max-height: 80%;
        width: 100%;
        overflow-y: scroll;
        /* display: flex;
        flex-direction: column;  */
    }

    .form-field {
        /* margin-bottom: 5px; */
        padding: 1rem 2rem;
    }

    .form-field input[type="text"], .form-field textarea {
        width: 40%;
    }

    .form-field textarea {
        min-height: 5rem;
        max-height: 10rem;
    }

    .form-field-title {
        margin-bottom: .5rem;
        font-weight: 500;
    }

    .btn-plus {
        color: black;
    }

    .box-danger {
        border: 1px solid var(--danger-color) !important;
    }
</style>
