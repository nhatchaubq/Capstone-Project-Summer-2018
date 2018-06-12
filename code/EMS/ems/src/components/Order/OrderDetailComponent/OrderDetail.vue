<template>
    <div v-if="order != null" class="material-box material-shadow">
        <div class="detail">
            <div class="detail-header">
                <div>
                    <span v-bind:style="priorityBadgeColor(order)" class="badge" style="position: relative; top: -.3rem">
                    {{ order.Priority }}
                    </span>
                    <span class="detail-title">
                        {{ order.Name }}
                    </span>
                </div>
                <div style="text-align: right; user-select: none;">
                    <a style="position: relative; top: .8rem;" v-on:click="editMode = !editMode">
                        <i class="fa" :class="{'fa-pencil-square-o': !editMode, 'fa-check-circle-o': editMode}" style=" font-size: 1rem; margin-right: 2px"></i>
                        {{ editMode ? 'Done' : 'Edit' }}
                    </a>
                </div>
            </div>
            <div style="width: 100%">
                <div class="detail-contents" style="margin-top: 1rem;">
                    <step-progress :workOrderStatusId="order.StatusID" :statusList="statusList"></step-progress>
                    <div v-if="editMode" style="margin-top: 1rem;">
                        <span class="detail-label" style="position: relative; top: .4rem; margin-right: 1rem;">Change status to:</span>
                        <div class="select">
                            <select>
                                <option :disabled="status.id <= order.StatusID" :selected="status.id == order.StatusID" :key="status.id" value="" v-for="status in statusList">
                                    {{ status.name }}
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="detail-contents">
                    <span class="detail-label">Equipments:</span>
                    <v-flex>
                        <v-expansion-panel popout>
                            <v-expansion-panel-content v-for="equipment in equipments" :key="equipment.Id">
                                <div slot="header" style="display: grid; grid-template-columns: 25% auto;">
                                    <div style="display: flex">
                                        <img v-show="equipment.Image" :src="equipment.Image" :alt="equipment.Name" style="width: 3rem; height: 3rem;">
                                    </div>
                                    <div style="display: grid; grid-template-rows: auto auto;">
                                        <div>
                                            {{ equipment.Name }}
                                        </div>                                            
                                        <div style="font-size: .9rem">
                                            Quantity: {{ equipment.EquipmentItems.length }}
                                        </div>
                                    </div>
                                </div>
                                <v-card v-for="equipmentItem in equipment.EquipmentItems" :key="equipmentItem.Id">
                                    <v-card-text style="font-size: .9rem">
                                        Serial #: <a>{{ equipmentItem.SerialNumber }}</a> | 
                                        <a href="">View position</a>
                                    </v-card-text>
                                </v-card>
                            </v-expansion-panel-content>
                        </v-expansion-panel>
                    </v-flex>
                </div>
                <div class="detail-contents">
                    <span class="detail-label">Location:</span>
                    <img src="http://images.indianexpress.com/2016/11/hazaribagh-759.jpg" />
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import Server from '@/config/config.js';
import StepProgress from '@/components/StepProgress/StepProgress.vue';

export default {
    name: 'order-detail',
    components: {
        StepProgress,
    },
    props: {
        order: null,
        statusList: null,
    },
    data() {
        return {
            equipments: [],
            editMode: false,
        }
    },
    methods: {
        priorityBadgeColor(order) {
            let tagColor = order.PriorityColor;
            return `border: 1px solid ${tagColor}; background-color: ${tagColor}`;
        }
    },
    watch: {
        'order': function() {
            if (this.order) {
                this.equipments = [];
                let url = `${Server.WORKORDER_API_PATH}/${this.order.Id}/equipments`;
                this.axios.get(url)
                    .then((res) => {
                        let data = res.data;
                        data.forEach(equipment => {
                            this.equipments.push(equipment);
                        });
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            }
        }
    }
}
</script>

<style scoped>
    .detail {
        padding: .5rem 1rem;
    }

    .detail-header {
        display: grid;
        grid-template-columns: 85% 15%
    }

    .detail-title {
        font-size: 2rem;
    }

    .detail-label {
        font-size: .98rem;
    }

    .detail-contents {
        margin-bottom: 1rem;
    }

    .material-box:hover {
        cursor: auto !important;
    }
</style>
