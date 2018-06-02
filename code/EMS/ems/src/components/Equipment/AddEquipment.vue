<template>
    <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Equipment
            </div>
            <div></div>
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
                    <form class="box" method="post" action="" enctype="multipart/form-data">
                        <div class="box__input">
                            <input class="box__file" ref="myFile" @change="fileChange" name="file" type="file" id="file"  data-multiple-caption="{count} files selected" multiple />
                            <label for="box__file"><strong>Choose a picture</strong></label>
                           
                        </div>
                    </form>
                </div>
                <label class="file-select">
                    <div class="select-button">
                    <span v-if="value">Choose a pciture aaaa: {{value.name}}</span>
                    <span v-else>Choose a picture</span>
                    </div>
                    <input type="file" @change="handleFileChange"/>
                </label>
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
  props: {
    value: File
  },
  methods: {
     
      handleFileChange(e) {
      this.$emit('input', e.target.files[0])
    }
  },
  watch: {
      file: function() {
          alert(this.file);
      }
  }
}
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

    .form-title-end button {
        /* font-weight: bold;
        color: white;
        border: 1px solid transparent;
        border-radius: 10px;
        padding: .6rem 1.5rem; */
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
        font-size: 13px;
    }
    .box__dragndrop,
    .box__uploading,
    .box__success,
    .box__error {
         display: none;
    }
    .input_picture{
        border-style: dashed;
        color: #bdbdbd;
    }
    .box__file {
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
    }

    .box__file:focus + label,
    .box__file + label:hover {
        background-color: red;
    }
    .box__file + label {
	    cursor: pointer; /* "hand" cursor */
    }
    .box__file:focus + label {
        outline: 1px dotted #000;
        outline: -webkit-focus-ring-color auto 5px;
    }
    .box__file + label * {
	    pointer-events: none;
    }   

    .file-select > .select-button {
        padding: 1rem;

        color: white;
        background-color:lightslategray;

        border-radius: .3rem;

        text-align: center;
        font-weight: bold;
    }

/* Don't forget to hide the original file input! */
    .file-select > input[type="file"] {
        display: none;
    }
</style>
