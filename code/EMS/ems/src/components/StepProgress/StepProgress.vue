<template>
    <div>
        <ul class="progressbar">
            <li class="tag" :class='{"active": status.id <= workOrderStatusId}' :key="'step' + status.id" v-for="status in statusList" :value="status.name">
                {{ status.name }}
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    name: 'step-progress',
    props: {
        workOrderStatusId: null,
        statusList: null,
    },
}
</script>

<style scoped>
    .progressbar {
        width: 100%;
        user-select: none;
    }
    .progressbar li {
        border: 1px solid #F5F5F5;
        position: relative;
        /* float: left; */
        display: inline;
        margin-right: 4%;
        text-align: center;
        font-size: 13px;
        z-index: 1;
        /* border: 1px solid var(--primary-color);
        border-radius: 10px; */
        padding: .2rem .4rem;
    }

    .progressbar li:last-child {
        margin: 0 !important;
    }

    .progressbar li:after {
        content: "";
        width: 40%;
        height: 3px;
        background: #F5F5F5;
        z-index: -1;
        position: absolute;
        top: .6rem;
        margin-left: 0;
    }

    .progressbar li:last-child:after {
        content: none;
    }

    li.active {
        background-color: var(--primary-color) !important;
        border: 1px solid var(--primary-color) !important;        
        color: white;
    }

    li.active:after {
        background: var(--primary-color);        
    }

    li.active + li {
        border: 1px solid var(--primary-color) !important;
    }
</style>
