<template>
    <div>
        <ul class="progressbar">
            <!-- workOrderStatus rejected - 6 or cancelled - 1002 -->
            <div v-if="workOrderStatus.name == 'Cancelled'">
                <li class="tag" :class="getStatusColorClass(workOrderStatus.name)">
                    {{ workOrderStatus.name }}
                </li>
            </div> <!-- workOrderStatus rejected - 6 or cancelled - 1002 -->
            <div v-else>
                <li class="tag" :class="status.id <= workOrderStatus.id ? getStatusColorClass(status.name) : ''" :key="'step' + status.id" v-for="status in statuses" :value="status.name">
                    {{ status.name }}
                </li>
            </div>
        </ul>
    </div>
</template>

<script>
export default {
    name: 'step-progress',
    props: {
        workOrderStatus: null,
        statusList: null,
    },
    data() {
        return {
            statuses: []
        }
    },
    created() {
        
    },
    methods: {
        getStatusColorClass(statusName) {
            switch(statusName) {
                case 'Requested': return 'requested';
                case 'Checked': return 'checked';
                case 'Approved': return 'approved';
                case 'Rejected': return 'rejected';
                case 'In Progress': return 'in-progress';
                case 'Closed': return 'closed';
                case 'Cancelled': return 'cancelled';
            }
        },
    },
    watch: {
        statusList: function() {
            if (this.statusList) {
                if (this.workOrderStatus && this.workOrderStatus.name == 'Rejected') {
                this.statuses = this.statusList.filter(status => status.name != 'Approved');
                } else {
                    this.statuses = this.statusList.filter(status => status.name != 'Rejected');
                }
            }
        }
    }
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
        z-index: 3;
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
        /* background-color: var(--primary-color) !important;
        border: 1px solid var(--primary-color) !important;        
        color: white; */
    }

    li.requested:after {
        background: var(--status-requested);        
    }

    li.requested:after {
        background: var(--status-requested);        
    }

    li.checked:after {
        background: var(--status-checked);        
    }

    li.approved:after {
        background: var(--status-approved);        
    }

    li.in-progress:after {
        background: var(--status-in-progress);        
    }

    li.closed:after {
        background: var(--status-closed);        
    }

    li.cancelled:after {
        background: var(--status-cancelled);        
    }

    li.requested + li {
        border: 1px solid var(--status-checked) !important;
    }

    li.checked + li.approved {
        border: 1px solid var(--status-approved) !important;
    }

    li.approved + li {
        border: 1px solid var(--status-in-progress) !important;
    }
    
    li.in-progress + li {
        border: 1px solid var(--status-closed) !important;
    }
</style>
