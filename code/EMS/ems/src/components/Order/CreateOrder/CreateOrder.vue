<template>
    <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Work Order
            </div>
            <div></div>
            <div class="form-title-end">
                <!-- <button id="btn-cancel" class="button" style="" v-on:click="cancel">Cancel</button> -->
                <button class="button" style="margin-right: .5rem" v-on:click="cancel">Cancel</button>
                <!-- <button id="btn-add" class="button is-primary">Create Work Order</button> -->
                <button class="button is-primary">Create Work Order</button>
            </div>
        </div>
        <div class="form-content">
            <div class="form-field is-horizonal">
                Status: 
                <label class="radio" :key="category.id" v-for="(category, index) in categories">
                    <input type="radio" name="category" :checked="index == 0">
                    {{ category.Name }}
                </label>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Title This Work Order (required)
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Công trình dự án Vinhomes">
                </div>
            </div>
            <div class="form-field">
                <div style="display: grid; grid-template-columns: 40% 10% 50%; grid-column-gap: 1rem;">
                    <div class="form-field-title">
                        Choose equipment(s) (required) (press <a class="btn-plus"><i class="fa fa-plus"></i></a> after select)
                    </div>
                    <div style="text-align: center">Quantity</div>
                    <div></div>
                </div>
                <div :key="index" v-for="(equipment, index) in selectedEquipments" style="display: grid; grid-template-columns: 40% 10% 50%; grid-column-gap: 1rem; margin-bottom: 1rem;">
                    <div style="padding-left: 1rem; display: grid; grid-template-columns: 5rem auto; grid-column-gap: 1rem;">
                        <img style="width: 100%; height: 5rem;" :src="equipment.image" alt="">
                        <div style="">
                            {{ equipment.name }}
                        </div>
                    </div>
                    <div>
                        <input style="text-align: center" class="input" type="number" min="1" v-model="equipment.quantity">
                    </div>
                    <div>
                        <a v-on:click="removeEquipment(equipment)">Delete</a>
                    </div>
                </div>
                <div style="display: grid; grid-template-columns: 40% 10% 50%; grid-column-gap: 1rem;">                
                    <div class="form-field-input">
                        <div style="width: 100%">
                            <model-select :options="equipmentOptions" placeholder="Select an equipment" v-model="selectedEquipment"></model-select>
                        </div>
                    </div>  
                    <div class="form-field-input">
                        <input style="text-align: center" type="number" min="1" class="input" v-model="selectedEquipmentQuantity">
                    </div>     
                    <div>
                        <a v-on:click="addEquipment()" style="position: relative; top: .5rem;" class="btn-plus"><i class="fa fa-plus"></i></a>
                    </div>           

                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Describe this work order (optional)
                </div>
                <div class="form-field-input">
                    <textarea class="input" rows="5"></textarea>
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

import {ModelSelect} from 'vue-search-select';

export default {
    data() {
        return {
            files: [],
            categories: [],
            equipmentOptions: [],
            selectedEquipment: {
                text: '',
                value: '',
                image: '',
            },
            selectedEquipmentQuantity: 1,
            selectedEquipments: [],
        }
    },
    created() {
        this.axios.get(Server.WORKORDER_CATEGORIES_API_PATH)
            .then((res) => {
                if (res.data) {
                    let data = res.data;
                    this.categories = data;
                }
            });
        this.axios.get(Server.EQUIPMENT_API_PATH)
            .then((res) => {
                if (res.data) {
                    let data = res.data;
                    data.forEach(element => {
                        let option = {
                            text: element.Equipment.Name,
                            value: element.Equipment.Id,
                            image: element.Equipment.Image,
                        };
                        this.equipmentOptions.push(option);
                    });
                }
            });
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
            if (this.selectedEquipment.value) {
                let index = this.selectedEquipments.findIndex(equipment => equipment.id == this.selectedEquipment.value);
                if (index < 0) {
                    let equipment = {
                        id: this.selectedEquipment.value,
                        name: this.selectedEquipment.text,
                        quantity: parseInt(this.selectedEquipmentQuantity),
                        image: this.selectedEquipment.image,
                    } 
                    this.selectedEquipments.push(equipment);
                } else {
                    let currentQuantity = parseInt(this.selectedEquipments[index].quantity);
                    this.selectedEquipments[index].quantity = currentQuantity + parseInt(this.selectedEquipmentQuantity);
                }
    
                this.selectedEquipment = { text: '', value: '', image: '' };
                this.selectedEquipmentQuantity = 1;
            }
        },
        removeEquipment(equipment) {
            this.selectedEquipments = this.selectedEquipments.filter(e => e.id != equipment.id);
        }
    },
    components: {
        ModelSelect,
    },
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
    }

    .btn-plus {
        color: black;
    }

    .box-danger {
        border: 1px solid var(--danger-color) !important;
    }
</style>
