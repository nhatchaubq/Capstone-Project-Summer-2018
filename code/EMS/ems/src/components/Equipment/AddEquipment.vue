<template>

    <div class="form">

        <div class="form-title">
            <div class="form-title-start">
                Add New Equipment
            </div>            
            <div class="form-title-end">
                <button id="" class="button is-rounded" style="margin-right: .6rem">Cancel</button>
                <button id="" class="button is-rounded is-primary">Create New Equipment</button>
            </div>
        </div>

        <div>           

            <div class="form-field-picture">
                <div class="form-field-title">
                    Picture
                </div>

                <div class="input_picture">                    
                    <label class="file-label" style="width: 100% !important"> 

                    <span class="file-cta">
                        <input class="file-input" type="file" ref="fileInput" v-on:change="inputFileChange" multiple />
                        <span class="file-icon">
                            <i class="fa fa-upload"></i>
                        </span>
                        <span class="file-label">
                            Choose images...
                        </span>
                    </span>
                        <div class="file-upload" v-bind:key="file.name" v-for="file in files" style="width: 100% !important;">
                            {{ file.name }}
                        <div>
                            <img class="file-upload" v-bind:src="getFilePath(file)"/>
                        </div>

                    </div>
                        </label>
                   
                </div> 
            </div>

            <div class="form-field">
                <div class="form-field-title">
                    Asset Name
                </div>
                <div class="form-field-input" >
                    <input type="text" class="input" placeholder="Asset Name">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Model
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Model Name">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Barcode
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Barcode">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Area
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Area">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Description
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Description">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Asset Category
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Asset Category">
                </div>
            </div>
        </div>
    </div>
</template>

<script>

import AddEquipment from "./AddEquipment";

export default {

  components: {
    AddEquipment
  },

  data() {
      return {
            files: [],       
      }
    },

  methods: {
     
      handleFileChange(e) {
      this.$emit('input', e.target.files[0])
    },
        inputFileChange() {
            this.files = this.$refs.fileInput.files;
        },
        getFilePath(file) {
            return window.URL.createObjectURL(file);
        }
    }

  };

</script>

<style scoped>
    .form {
        background-color: white;
        margin: 0 1.5rem;
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


    #btn-cancel {
        background-color: #bdbdbd;
    }

    #btn-add {
        background-color: var(--primary-color);
        padding: 13px;
        color: white;
        border-radius: 10px;
        box-shadow: 4px 4px 5px #bdbdbd;
    }

    .form-field {
        /* margin-bottom: 5px; */
        padding: 1rem 3rem;
    }
    .form-field-picture{
        padding: 1rem 3rem;
        border: none;
    }

    .form-field-title {
        font-size: 15px;
    }

    .input_picture{
        padding: 1rem 3rem 1rem 3rem;
        outline: 2px dashed #a8a8a8fb;
        background-color:#f0efeffb;
        display: flex;
    }
   .file-cta{
       border: none;
       background-color: #a8a8a8fb;
       margin: auto;
   }
   .file-upload{
       padding-left: 2rem;
   }
    .box{
        height: 5rem;
        outline: none;
        border-style: none; 
        background-color: aliceblue;
        align-items: center;

        font-size: 13px;
    }

    
    /* .box__file {
        width: 0.1px;
        height: 0.1px;
        opacity: 0;
        overflow: hidden;
        position: absolute;
        z-index: -1;
    }
    .box__file + label {
        font-size: 1.25em;
        font-weight: 700;
        color: white;
        background-color: black;
        display: inline-block;
    } */

</style>
