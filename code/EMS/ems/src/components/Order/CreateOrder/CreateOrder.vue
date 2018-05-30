<template>
    <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Work Order
            </div>
            <div></div>
            <div class="form-title-end">
                <button id="" class="button is-rounded" style="margin-right: .6rem">Cancel</button>
                <button id="" class="button is-rounded is-primary">Create Work Order</button>
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
                <div class="form-field-title">
                    Title This Work Order (required)
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {

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
    }

    .form-field {
        /* margin-bottom: 5px; */
        padding: 1rem 3rem;
    }

    .form-field-title {
        font-size: 13px;
    }
</style>
