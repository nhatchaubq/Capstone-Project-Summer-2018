<template>
    <div v-if="config && configOriginal && configCopy">
        <div v-if="configOriginal.createWorkOrder">
            <div style="font-weight: 500; margin-top: 1rem; font-size: 1.3rem">Creating/editing work order 
                <span style="font-weight: 400; font-size: 1rem;">
                    <a v-if="!editingCreateWorkOrderConfig" v-on:click="editingCreateWorkOrderConfig = true;"><i class="fa fa-pencil-square-o"></i> edit</a>
                    <span v-if="editingCreateWorkOrderConfig">
                        <a :style="errorPresetNameCantBeEmptyIndex.length > 0
                                    || errorPresetNameCantBeNormalIndex.length > 0
                                    || errorPresetNameOfCreateOrderConfigIndex.length > 0
                                    || tobeErrorPresetNameOfCreateOrderConfigIndex.length > 0
                                    || !isCreateOrderConfigChanged ? 'cursor: not-allowed; color: var(--shadow) !important;' : ''" 
                            v-on:click="() => {
                                for (let i = 0; i < this.configOriginal.createWorkOrder.presets.length; i++) {
                                    checkValidPresetName(i);
                                }
                                if (errorPresetNameCantBeEmptyIndex.length == 0
                                    && errorPresetNameCantBeNormalIndex.length == 0
                                    && errorPresetNameOfCreateOrderConfigIndex.length == 0
                                    && tobeErrorPresetNameOfCreateOrderConfigIndex.length == 0
                                    && isCreateOrderConfigChanged) {                                        
                                    configCopy = JSON.stringify(configOriginal);
                                    configCopy = JSON.parse(configCopy);
                                    $socket.emit('CONFIGURATION_CHANGED', configOriginal);
                                    editingCreateWorkOrderConfig = false;
                                }
                        }">save changes</a> | 
                        <a v-on:click="() => {
                            errorPresetNameCantBeEmptyIndex = [];
                            errorPresetNameCantBeNormalIndex = [];
                            errorPresetNameOfCreateOrderConfigIndex = [];
                            tobeErrorPresetNameOfCreateOrderConfigIndex = [];
                            let configJson = JSON.stringify(configCopy.createWorkOrder)
                            configOriginal.createWorkOrder = JSON.parse(configJson);
                            editingCreateWorkOrderConfig = false;
                        }">cancel</a>
                    </span>
                </span>
            </div>
            <div>
                <div style="padding-left: 1rem; margin-bottom: .5rem; user-select: none">
                    <div style="margin-bottom: .5rem" class="is-horizontal">
                        <div style="font-size: .95rem"><span style="position: relative; top: .5rem;">Maximum conflicting work order: <span v-if="!editingCreateWorkOrderConfig">{{ configOriginal.createWorkOrder.maximumConflictWorkOrders }}</span></span>
                        <input class="input" style="width: 7%; text-align: right;" v-if="editingCreateWorkOrderConfig" v-model.number="configOriginal.createWorkOrder.maximumConflictWorkOrders" type="number" min="0" step="1" v-on:input="() => {
                            if (configOriginal.createWorkOrder.maximumConflictWorkOrders < 0 || configOriginal.createWorkOrder.maximumConflictWorkOrders == '') {
                                configOriginal.createWorkOrder.maximumConflictWorkOrders = 0;
                            }
                            configOriginal.createWorkOrder.maximumConflictWorkOrders = parseInt(configOriginal.createWorkOrder.maximumConflictWorkOrders);
                            checkCreateOrderConfigChanged();
                        }"/> <span style="position: relative; top: .5rem;"> order<span v-if="configOriginal.createWorkOrder.maximumConflictWorkOrders > 1">s</span></span></div>
                    </div>
                    <div style="margin-bottom: 1rem" class="is-horizontal">
                        <div style="font-size: .95rem"><span style="position: relative; top: .5rem;">Maximum work order duration: <span v-if="!editingCreateWorkOrderConfig">{{ configOriginal.createWorkOrder.maximumWorkOrderDuration }}</span></span>
                        <input class="input" style="width: 7%; text-align: right;" v-if="editingCreateWorkOrderConfig" v-model.number="configOriginal.createWorkOrder.maximumWorkOrderDuration" type="number" min="1" step="1" v-on:input="() => {
                            if (configOriginal.createWorkOrder.maximumWorkOrderDuration < 1 || configOriginal.createWorkOrder.maximumWorkOrderDuration == '') {
                                configOriginal.createWorkOrder.maximumWorkOrderDuration = 1;
                            }
                            configOriginal.createWorkOrder.maximumWorkOrderDuration = parseInt(configOriginal.createWorkOrder.maximumWorkOrderDuration);
                            checkCreateOrderConfigChanged();
                        }"/>
                        <span v-if="!editingCreateWorkOrderConfig" style="position: relative; top: .5rem;"> {{ configOriginal.createWorkOrder.maximumWorkOrderDurationType }}<span v-if="configOriginal.createWorkOrder.maximumWorkOrderDuration > 1">s</span></span>
                        <span v-if="editingCreateWorkOrderConfig" style="margin-left: .5rem; position: relative; top: .5rem;"> 
                            <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" name="maximumWorkOrderDurationType" :checked="configOriginal.createWorkOrder.maximumWorkOrderDurationType == 'year'" v-on:input="() => {
                                configOriginal.createWorkOrder.maximumWorkOrderDurationType = 'year';
                                checkCreateOrderConfigChanged();
                            }"/> year<span v-if="configOriginal.createWorkOrder.maximumWorkOrderDuration > 1">s</span></label>
                            <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" name="maximumWorkOrderDurationType" :checked="configOriginal.createWorkOrder.maximumWorkOrderDurationType == 'month'" v-on:input="() => {
                                configOriginal.createWorkOrder.maximumWorkOrderDurationType = 'month';
                                checkCreateOrderConfigChanged();
                            }"/> month<span v-if="configOriginal.createWorkOrder.maximumWorkOrderDuration > 1">s</span></label>
                            <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" name="maximumWorkOrderDurationType" :checked="configOriginal.createWorkOrder.maximumWorkOrderDurationType == 'day'" v-on:input="() => {
                                configOriginal.createWorkOrder.maximumWorkOrderDurationType = 'day';
                                checkCreateOrderConfigChanged();
                            }"/> day<span v-if="configOriginal.createWorkOrder.maximumWorkOrderDuration > 1">s</span></label>
                        </span></div>
                    </div>
                    <div>
                        <div style="font-size: .95rem">Equipment sorting presets: <a v-if="editingCreateWorkOrderConfig" v-on:click="() => {
                            checkValidPresetName(1);
                            configOriginal.createWorkOrder.presets.push({
                                name: '',
                                workOrderDuration: 0,
                                workOrderDurationType: 'day',
                                durationFromCreateDate: 0,
                                durationFromCreateDateType: 'day',
                                durationFactor: 0.5,
                                distanceFactor: 0.5
                            });
                            isCreateOrderConfigChanged = true;
                        }"><i class="fa fa-plus-circle"></i> add new preset</a></div>
                    </div>
                    <div style="padding-left: 1rem; font-size: .9rem" :key="'createWorkOrderPreset' + index" v-for="(preset, index) in configOriginal.createWorkOrder.presets">
                        <div>
                            <div>
                                <span>
                                    <span style="position: relative; top: .5rem" v-if="!editingCreateWorkOrderConfig || (editingCreateWorkOrderConfig && index == 0)">{{ preset.name }}:</span>
                                    <input v-if="editingCreateWorkOrderConfig && index > 0"
                                            style="width: 20%" v-model.trim="preset.name" class="input" type="text"
                                            placeholder="Preset name"
                                            :style="errorPresetNameCantBeEmptyIndex.includes(index)
                                                    || errorPresetNameCantBeNormalIndex.includes(index)
                                                    || errorPresetNameOfCreateOrderConfigIndex.includes(index)
                                                    || tobeErrorPresetNameOfCreateOrderConfigIndex.includes(index) ? 'border: 1px solid var(--danger-color) !important;' : ''"
                                            v-on:input="() => {
                                                checkValidPresetName(index);
                                                checkCreateOrderConfigChanged();
                                            }"/> 
                                    <a style="margin-left: .3rem; position: relative; top: .5rem" v-if="editingCreateWorkOrderConfig && index > 0" v-on:click="() => {
                                        configOriginal.createWorkOrder.presets.splice(index, 1);
                                        checkValidPresetName(index);
                                        checkCreateOrderConfigChanged();
                                    }"><i class="fa fa-minus-circle"></i> remove</a>
                                </span>
                            </div>
                            <div class="error-text" v-if="errorPresetNameCantBeNormalIndex.length > 0 || errorPresetNameCantBeNormalIndex.length > 0 || errorPresetNameOfCreateOrderConfigIndex.length > 0">
                                <div v-if="errorPresetNameCantBeEmptyIndex.includes(index) ">{{ErrorStrings.ErrorEmptyPresetName}}</div>
                                <div v-else-if="errorPresetNameCantBeNormalIndex.includes(index)">{{ErrorStrings.ErrorPresetNameCantBeNormal}}</div>
                                <div v-if="errorPresetNameOfCreateOrderConfigIndex.includes(index)">{{ErrorStrings.ErrorPresetNameIsDuplicated}}</div>
                            </div>
                        </div>
                        <div class="is-horizontal" :style="editingCreateWorkOrderConfig ? 'margin: .5rem 0;' : ''">
                            <span style="position: relative; top: .5rem">- Duration of work order: <span v-if="!editingCreateWorkOrderConfig">{{ preset.workOrderDuration }}</span></span>
                            <input style="width: 7%; text-align: right;" v-if="editingCreateWorkOrderConfig" v-model.number="preset.workOrderDuration" class="input" type="number" min="0" step="1" v-on:input="() => {
                                if (preset.workOrderDuration < 0 || preset.workOrderDuration == '') {
                                    preset.workOrderDuration = 0;
                                }
                                preset.workOrderDuration = parseInt(preset.workOrderDuration);
                                checkCreateOrderConfigChanged();
                            }"/>
                            <span style="position: relative; top: .5rem" v-if="!editingCreateWorkOrderConfig && preset.workOrderDuration > 0"> {{ preset.workOrderDurationType }}<span v-if="preset.workOrderDuration > 1">s</span></span>
                            <span v-if="editingCreateWorkOrderConfig && preset.workOrderDuration > 0" style="margin-left: .3rem; position: relative; top: .5rem">
                                <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" :name="'workOrderDurationType' + index" :checked="preset.workOrderDurationType == 'year'" v-on:input="() => {
                                    preset.workOrderDurationType = 'year';
                                    checkCreateOrderConfigChanged();
                                }"/> year<span v-if="preset.workOrderDuration > 1">s</span></label>
                                <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" :name="'workOrderDurationType' + index" :checked="preset.workOrderDurationType == 'month'" v-on:input="() => {
                                    preset.workOrderDurationType = 'month';
                                    checkCreateOrderConfigChanged();
                                }"/> month<span v-if="preset.workOrderDuration > 1">s</span></label>
                                <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" :name="'workOrderDurationType' + index" :checked="preset.workOrderDurationType == 'day'" v-on:input="() => {
                                    preset.workOrderDurationType = 'day';
                                    checkCreateOrderConfigChanged();
                                }"/> day<span v-if="preset.workOrderDuration > 1">s</span></label>
                            </span>
                        </div>
                        <div class="is-horizontal" :style="editingCreateWorkOrderConfig ? 'margin: .5rem 0;' : ''">
                            <span style="position: relative; top: .5rem">- Days from created date: <span v-if="!editingCreateWorkOrderConfig">{{ preset.durationFromCreateDate }}</span></span><input style="width: 7%; text-align: right;" v-if="editingCreateWorkOrderConfig" v-model.number="preset.durationFromCreateDate" class="input" type="number" min="0" step="1" v-on:input="() => {
                                if (preset.durationFromCreateDate < 0 || preset.durationFromCreateDate == '') {
                                    preset.durationFromCreateDate = 0;
                                }
                                preset.durationFromCreateDate = parseInt(preset.durationFromCreateDate);
                                checkCreateOrderConfigChanged();
                            }"/>                            
                            <span style="position: relative; top: .5rem" v-if="!editingCreateWorkOrderConfig && preset.durationFromCreateDate > 0"> {{ preset.durationFromCreateDateType }}<span v-if="preset.durationFromCreateDate > 1">s</span></span>
                            <span v-if="editingCreateWorkOrderConfig && preset.durationFromCreateDate > 0" style="margin-left: .3rem; position: relative; top: .5rem">
                                <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" :name="'durationFromCreateDateType' + index" :checked="preset.durationFromCreateDateType == 'year'" v-on:input="() => {
                                    preset.durationFromCreateDateType = 'year';
                                    checkCreateOrderConfigChanged();
                                }"/> year<span v-if="preset.durationFromCreateDate > 1">s</span></label>
                                <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" :name="'durationFromCreateDateType' + index" :checked="preset.durationFromCreateDateType == 'month'" v-on:input="() => {
                                    preset.durationFromCreateDateType = 'month';
                                    checkCreateOrderConfigChanged();
                                }"/> month<span v-if="preset.durationFromCreateDate > 1">s</span></label>
                                <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" :name="'durationFromCreateDateType' + index" :checked="preset.durationFromCreateDateType == 'day'" v-on:input="() => {
                                    preset.durationFromCreateDateType = 'day';
                                    checkCreateOrderConfigChanged();
                                }"/> day<span v-if="preset.durationFromCreateDate > 1">s</span></label>
                            </span>
                        </div>
                        <div class="is-horizontal" :style="editingCreateWorkOrderConfig ? 'margin: .5rem 0;' : ''">
                            <span style="position: relative; top: .5rem">- Work order duration factor: <span v-if="!editingCreateWorkOrderConfig">{{ preset.durationFactor }}</span></span><input style="width: 7%; text-align: right;" v-if="editingCreateWorkOrderConfig" v-model.number="preset.durationFactor" class="input" type="number" min="0" max="1" step="0.1" v-on:input="() => {
                                if (preset.durationFactor < 0 || preset.durationFactor == '') {
                                    preset.durationFactor = 0;
                                } else if (preset.durationFactor > 1) {
                                    preset.durationFactor = 1;
                                }
                                preset.durationFactor = parseFloat(preset.durationFactor.toFixed(2));
                                preset.distanceFactor = parseFloat((1 - preset.durationFactor).toFixed(2));
                                checkCreateOrderConfigChanged();
                            }"/><span style="position: relative; top: .5rem">%</span>
                        </div>
                        <div class="is-horizontal" style="margin-bottom: .5rem;">
                            <span style="position: relative; top: .5rem;">- Distance from warehouse factor: <span v-if="!editingCreateWorkOrderConfig">{{ preset.distanceFactor }}</span></span><input style="width: 7%; text-align: right;" v-if="editingCreateWorkOrderConfig" v-model.number="preset.distanceFactor" class="input" type="number" min="0" max="1" step="0.1" v-on:input="() => {
                                if (preset.distanceFactor < 0 || preset.distanceFactor == '') {
                                    preset.distanceFactor = 0;
                                } else if (preset.distanceFactor > 1) {
                                    preset.distanceFactor = 1;
                                }
                                preset.distanceFactor = parseFloat(preset.distanceFactor.toFixed(2));
                                preset.durationFactor = parseFloat((1 - preset.distanceFactor).toFixed(2));
                                checkCreateOrderConfigChanged();
                            }"/><span style="position: relative; top: .5rem">%</span>
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
    created() {
        if (this.config) {
            let configJson = JSON.stringify(this.config);
            this.configOriginal = JSON.parse(configJson);
            this.configCopy = JSON.parse(configJson);
        }
    },
    data() {
        return {
            ErrorStrings: {
                ErrorPresetNameCantBeNormal: 'Preset\'s name can not be \"Normal\"',
                ErrorEmptyPresetName: 'Preset\'s name cant not be empty',
                ErrorPresetNameIsDuplicated: 'This name is duplicated with other presets',
            },
            CreateOrderErrors: {
                ErrorPresetNameCantBeNormal: '',
                ErrorEmptyPresetName: '',
                ErrorPresetNameIsDuplicated: '',
            },
            configOriginal: null,
            configCopy: null,
            errorPresetNameCantBeEmptyIndex: [],
            errorPresetNameCantBeNormalIndex: [],
            errorPresetNameOfCreateOrderConfigIndex: [],
            tobeErrorPresetNameOfCreateOrderConfigIndex: [],
            isCreateOrderConfigChanged: false,
            editingCreateWorkOrderConfig: false,
        }
    },
    watch: {
        config: function() {
            if(this.config) {
                let configJson = JSON.stringify(this.config);
                this.configOriginal = JSON.parse(configJson);
                this.configCopy = JSON.parse(configJson);
            }
        }
    },
    methods: {
        checkValidPresetName(index) {
            if (index > 0 && index < this.configOriginal.createWorkOrder.presets.length) {
                let presets = this.configOriginal.createWorkOrder.presets;
                if (presets[index].name == '') {
                    this.errorPresetNameCantBeEmptyIndex.push(index);
                } else {
                    this.errorPresetNameCantBeEmptyIndex.splice(index, 1);
                    if (presets[index].name.toLowerCase() == 'normal') {
                        if (!this.errorPresetNameCantBeNormalIndex.includes(index)) {
                            this.errorPresetNameCantBeNormalIndex.push(index);
                        }
                    } else {
                        this.errorPresetNameCantBeNormalIndex.splice(index, 1);
                        let toCheckPreset = presets[index];
                        this.errorPresetNameOfCreateOrderConfigIndex = [];
                        this.tobeErrorPresetNameOfCreateOrderConfigIndex = [];
                        for (let i = 1; index > presets.length; i++) {
                            if (index != i) {
                                let tobeCheckedPreset = presets[i];
                                if (toCheckPreset.name == tobeCheckedPreset.name) {
                                    if (!this.errorPresetNameOfCreateOrderConfigIndex.includes(index)) {
                                        this.errorPresetNameOfCreateOrderConfigIndex.push(index);
                                    }
                                    if (!this.tobeErrorPresetNameOfCreateOrderConfigIndex.includes(i)) {
                                        this.tobeErrorPresetNameOfCreateOrderConfigIndex.push(i);
                                    }
                                }
                            }
                        }
                    }
                }                
            }
        },
        checkCreateOrderConfigChanged() {
            this.isCreateOrderConfigChanged = false;
            const createWorkOrderConfigOriginal = this.configOriginal.createWorkOrder;
            const createWorkOrderConfigCopy = this.configCopy.createWorkOrder;
            if (createWorkOrderConfigOriginal && createWorkOrderConfigCopy) {
                this.isCreateOrderConfigChanged = createWorkOrderConfigOriginal.maximumConflictWorkOrders != createWorkOrderConfigCopy.maximumConflictWorkOrders
                            || createWorkOrderConfigOriginal.maximumWorkOrderDuration != createWorkOrderConfigCopy.maximumWorkOrderDuration
                            || createWorkOrderConfigOriginal.maximumWorkOrderDurationType != createWorkOrderConfigCopy.maximumWorkOrderDurationType;
                if (!this.isCreateOrderConfigChanged) {
                    for (let i = 0; i < createWorkOrderConfigOriginal.presets.length; i++) {
                        if (createWorkOrderConfigOriginal.presets.length == createWorkOrderConfigCopy.presets.length) {
                            const createWorkOrderConfigOriginalPreset = createWorkOrderConfigOriginal.presets[i];
                            const createWorkOrderConfigCopyPreset = createWorkOrderConfigCopy.presets[i];
                            this.isCreateOrderConfigChanged = createWorkOrderConfigOriginalPreset.name != createWorkOrderConfigCopyPreset.name
                                    ||createWorkOrderConfigOriginalPreset.workOrderDuration != createWorkOrderConfigCopyPreset.workOrderDuration
                                    ||createWorkOrderConfigOriginalPreset.workOrderDurationType != createWorkOrderConfigCopyPreset.workOrderDurationType
                                    ||createWorkOrderConfigOriginalPreset.durationFromCreateDate != createWorkOrderConfigCopyPreset.durationFromCreateDate
                                    ||createWorkOrderConfigOriginalPreset.durationFromCreateDateType != createWorkOrderConfigCopyPreset.durationFromCreateDateType
                                    ||createWorkOrderConfigOriginalPreset.durationFactor != createWorkOrderConfigCopyPreset.durationFactor
                                    ||createWorkOrderConfigOriginalPreset.distanceFactor != createWorkOrderConfigCopyPreset.distanceFactor;
                            if (this.isCreateOrderConfigChanged) break;
                        } else {
                            this.isCreateOrderConfigChanged = true;
                            break;
                        }                        
                    }
                }
            }
        },
        showAlert(msg) {
            alert(msg);
        }
    }
}
</script>

<style scoped>

</style>
