<template>
    <div style="width: 60%">
        <div>
            <div style="font-weight: 500; margin-top: 1rem; font-size: 1.1rem">Create Work Order</div>
            <div>
                <div style="margin-bottom: .5rem;">
                    <div>
                        <div>Preset: <a>add new preset</a></div>
                    </div>
                    <div style="margin-top: .5rem; padding-left: 1rem; font-size: .9rem" :key="'createOrderConfig' + index" v-for="(createOrderConfig, index) in config.createWorkOrder">
                        <div>{{ createOrderConfig.name }}: <a style="user-select: none" @click="() => {
                                if (!editCreateOrderConfig.includes(index)) {
                                    editCreateOrderConfig.push(index);
                                } else {
                                    editCreateOrderConfig = editCreateOrderConfig.filter(i => i != index);
                                }
                            }"><span v-if="!editCreateOrderConfig.includes(index)">edit</span><span v-if="editCreateOrderConfig.includes(index)">done</span></a> | <a>remove</a></div>
                        <div>
                            - Duration of work order: {{ createOrderConfig.workOrderDuration }}
                        </div>
                        <div>
                            - Days from created date: {{ createOrderConfig.daysFromCreateDate }}
                        </div>
                        <div>
                            - Work order duration factor: {{ createOrderConfig.durationFactor }}%
                        </div>
                        <div>
                            - Distance from warehouse factor: {{ createOrderConfig.distanceFactor }}%
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { sync } from 'vuex-pathify';

export default {
    computed: {
        config: sync('config'),
    },
    data() {
        return {
            editCreateOrderConfig: []
        }
    }
}
</script>

<style scoped>

</style>
