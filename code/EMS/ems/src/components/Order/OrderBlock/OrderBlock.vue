<template>
    <div class="material-box material-shadow-animate order-block">
        <div class="order-block-title">{{ order.Name }}</div>
        <div class="order-status-icon">
            <!-- <i class="material-icons">lock_open</i> -->
            <i class="fa" :class="makeStatusIcon(order)"></i>            
        </div>
        <div class="order-block-info">
            <div style="color: white" :style="`background-color: ${order.PriorityColor}`" class="tag">{{ order.Priority }}</div>
            <div>#{{ order.Id }}</div>
            <div>
                <i class="fa fa-user"></i>
                {{ order.RequestUsername }}
            </div>
            <div>
                <i class="fa fa-calendar"></i>
                {{ order.CreateDate }}
            </div>
        </div>
        <div class="order-status">
            {{ order.WorkOrderStatus }}            
        </div>
        <div class="order-block-location">
            <i class="material-icons">location_on</i>
            {{ order.Location.Name }} - {{ order.Location.Address }}
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
            let tagColor = order.PriorityColor;
            return `border: 1px solid ${tagColor}; background-color: ${tagColor}`;
        },
        makeStatusIcon(order) {
            switch(order.StatusID) {
                case 1: { // request
                    return 'fa-level-up';
                }
                case 2: // checked
                    return 'fa-check';
                case 3: // approved
                    return 'fa-approve';
                case 4: // delivered
                    return 'fa-handshake-o';
                case 5: // return
                    return 'fa-archive';
                case 6: // done
                    return 'fa-check-square-o';
            }
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
        /* line-height: 2.5rem; */
        font-size: .9rem;
        display: flex;
        justify-content: center;
        align-content: flex-end;
        user-select: none;
    }

    .order-status-icon {
        font-size: 1.5rem;
        display: flex;
        justify-content: center;
        align-content: flex-start;
        user-select: none;
    }

    .order-status-icon i {
        position: relative;
        top: .6rem;
    }

    /* .order-status i {
        position: relative;
        top: .4rem;
    } */

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
        font-size: 1rem;
        position: relative;
        top: .1rem;
    }
</style>
