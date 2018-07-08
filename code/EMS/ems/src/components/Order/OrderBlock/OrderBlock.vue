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
                {{ authUser.Id == order.RequestUserID ? 'ChauBQN123456' : order.RequestUsername }}
            </div>
            <div>
                <i class="fa fa-calendar"></i>
                {{ getFormatDate(order.CreateDate) }}
            </div>
        </div>
        <div class="order-status" :class="statusColor(order)">
            {{ order.WorkOrderStatus }}            
        </div>
        <div class="order-block-location">
            <i class="material-icons">location_on</i>
            {{ order.Location.Name }} - {{ order.Location.Address }}
        </div>
    </div>
</template>

<script>
import moment from 'moment';
export default {
    name: 'order-block',
    props: {
        order: null,
    },
    computed: {
        authUser() {
            return JSON.parse(window.localStorage.getItem('user'));
        }
    },
    methods: {
        priorityBadgeColor(order) {
            let tagColor = order.PriorityColor;
            return `border: 1px solid ${tagColor}; background-color: ${tagColor}`;
        },
        makeStatusIcon(order) {
            switch(order.StatusID) {
                case 1: { // Requested
                    return 'fa-level-up requested';
                }
                case 2: { // Checked
                    return 'fa-check checked';
                }
                case 3: { // Approved
                    return 'fa-thumbs-up approved';
                }
                case 4: { // InProgress
                    return 'fa-thumbs-down rejected';
                }
                case 5: { // Closed
                    return 'fa-tasks in-progress';
                }
                case 6: { // Rejected
                    return 'fa-archive closed';
                }
                case 1002: { // Cancelled
                    return 'fa-ban cancelled';
                }
            }
        },
        statusColor(order) {
            switch(order.StatusID) {
                case 1: { // Requested
                    return 'requested';
                }
                case 2: { // Checked
                    return 'checked';
                }
                case 3: { // Approved
                    return 'approved';
                }
                case 4: { // InProgress
                    return 'rejected';
                }
                case 5: { // Closed
                    return 'in-progress';
                }
                case 6: { // Rejected
                    return 'closed';
                }
                case 1002: { // Cancelled
                    return 'cancelled';
                }
            }
        },
        getFormatDate(date) {
            return moment(date).format('L');
        },
    }
}
</script>

<style>
    .order-block {
        display: grid;
        grid-template-columns: 80% 20%;
        grid-template-rows: 1 1 1;        
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
        /* align-content: center; */
        color: #616161;
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
        color: #616161;        
    }

    .order-block-location i {
        font-size: 1rem;
        position: relative;
        top: .1rem;
    }

    .requested {
        color: var(--status-requested);
    }

    .checked {
        color: var(--status-checked);
    }

    .approved {
        color: var(--status-approved);
    }

    .rejected {
        color: var(--status-rejected);
    }

    .in-progress {
        color: var(--status-in-progress);
    }

    .closed {
        color: var(--status-closed);
    }

    .cancelled {
        color: var(--status-cancelled);
    }
</style>
