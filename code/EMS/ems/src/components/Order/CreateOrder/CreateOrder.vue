<template>
    <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Work Order
            </div>
            <div></div>
            <div class="form-title-end">
                <button id="btn-cancel" class="button" style="" v-on:click="cancel">Cancel</button>
                <button id="btn-add" class="button">Create Work Order</button>
            </div>
        </div>
        <div>
            <div class="form-field">
                <div class="form-field-title">
                    Title This Work Order (required)
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Title This Work Order (required)
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Title This Work Order (required)
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            <div class="form-field">
                <div class="file is-boxed has-name">
                    <label class="file-label" style="width: 100% !important">
                        <input class="file-input" type="file" ref="fileInput" v-on:change="inputFileChange" multiple />
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
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            files: [],
        }
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
        }
    }
}
</script>

<style scoped>
    .form {
        background-color: white;
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

    .form-field {
        /* margin-bottom: 5px; */
        padding: 1rem 3rem;
    }

    .form-field-title {
        font-size: 13px;
    }
</style>
