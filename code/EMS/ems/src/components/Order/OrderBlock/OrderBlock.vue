<template>
    <div class="material-box material-shadow-animate order-block">
        <div class="order-block-title">{{ order.name }}</div>
        <div class="order-status">
            <i class="material-icons">lock_open</i>
            {{ order.status }}
        </div>
        <div class="order-block-info">
            <div v-bind:style="priorityBadgeColor(order)" class="badge">{{ order.priority }}</div>
            <div>#{{ order.orderNumber }}</div>
            <div>
                <i class="fa fa-user"></i>
                {{ order.createdBy }}
            </div>
            <div>
                <i class="fa fa-calendar"></i>
                {{ order.requestDate }}
            </div>
        </div>
        <div class="order-block-location">
            <i class="material-icons">location_on</i>
            {{ order.location }}
        </div>
    </div>
</template>

<script>
export default {
    name: 'order-block',
    props: {
        order: null,
    },
    methods: {
        priorityBadgeColor(order) {
            let tagColor = order.tagColor;
            return `border: 1px solid ${tagColor}; background-color: ${tagColor}`;
        }
    }
}
</script>

<style>
    .order-block {
        display: grid;
        grid-template-columns: 80% 20%;
        grid-template-rows: 1 1 1;        
        margin-bottom: 1rem;
    }

    .order-block:hover {
        cursor: pointer;
    }

    .order-block-title {
        grid-column: 1;
        grid-row: 1;
        font-size: 25px;
        font-weight: 500;
        margin-bottom: 5px;
    }

    .order-status {
        line-height: 2.5rem;
        font-size: 15px;
        display: flex;
        justify-content: center;
        align-content: center;
        user-select: none;
    }

    .order-status i {
        position: relative;
        top: .4rem;
    }

    .order-block-info {
        grid-column: 1;
        grid-row: 2;
        font-size: 14px;
        width: 100%;
        display: flex;
        align-content: center;
        color: #9e9e9e;
        margin-bottom: 10px;        
    }

    .order-block-info .badge {
        user-select: none;
    }

    .order-block-info div {
        padding: .1rem .4rem;
        margin-right: 10px;
    }

    .order-block-location {
        grid-column: 1;
        grid-row: 3;        
        display: flex;
        align-content: center;
        font-size: 14px;        
        color: #9e9e9e;        
    }

    .order-block-location i {
        font-size: 1.2rem;
        position: relative;
        top: .1rem;
    }
</style>
