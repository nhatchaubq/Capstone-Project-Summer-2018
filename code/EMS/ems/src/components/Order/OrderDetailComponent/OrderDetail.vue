<template>
    <div v-if="order != null" class="material-box material-shadow">
        <div class="detail">
            <div>
                <span class="detail-title">{{ order.ProjectName }}</span>
            </div>
            <div style="width: 100%">
                <div>
                    <step-progress :workOrderStatusId="order.StatusID" :statusList="statusList"></step-progress>
                </div>
                <div>
                    <v-flex>
                        <v-expansion-panel popout>
                        <v-expansion-panel-content v-for="detail in order.WorkOrderDetails" :key="detail.EquipmentItem.Id">
                            <div slot="header">Item</div>
                            <v-card>
                            <v-card-text>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</v-card-text>
                            </v-card>
                        </v-expansion-panel-content>
                        </v-expansion-panel>
                    </v-flex>
                </div>
                <div>
                    Construction site:
                    <img src="http://images.indianexpress.com/2016/11/hazaribagh-759.jpg" />
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import StepProgress from '@/components/StepProgress/StepProgress.vue';

export default {
    name: 'order-detail',
    components: {
        StepProgress,
    },
    props: {
        order: null,
        statusList: null,
    }
}
</script>

<style scoped>
    .detail {
        padding: .5rem 1rem;
    }

    .detail-title {
        font-size: 2rem;
    }

    .material-box:hover {
        cursor: auto !important;
    }
</style>
