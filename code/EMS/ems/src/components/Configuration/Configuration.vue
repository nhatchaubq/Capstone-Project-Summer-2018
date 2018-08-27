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
                                    || errorDurationFromCreateDateIndex.length > 0
                                    || tobeErrorDurationFromCreateDateIndex.length > 0
                                    || errorDurationIsGreaterThanMaximumIndex.length > 0
                                    || errorRuntimeFactorIndex.length > 0
                                    || tobeErrorRuntimeFactorIndex.length > 0
                                    || errorDistanceFactorIndex.length > 0
                                    || tobeErrorDistanceFactorIndex.length > 0
                                    || !isCreateOrderConfigChanged ? 'cursor: not-allowed; color: var(--shadow) !important;' : ''" 
                            v-on:click="() => {
                                for (let i = 0; i < this.configOriginal.createWorkOrder.presets.length; i++) {
                                    checkValidPresetName(i);
                                }
                                if (errorPresetNameCantBeEmptyIndex.length == 0
                                    && errorPresetNameCantBeNormalIndex.length == 0
                                    && errorPresetNameOfCreateOrderConfigIndex.length == 0
                                    && tobeErrorPresetNameOfCreateOrderConfigIndex.length == 0
                                    && errorDurationFromCreateDateIndex.length == 0
                                    && tobeErrorDurationFromCreateDateIndex.length == 0
                                    && errorDurationIsGreaterThanMaximumIndex.length == 0
                                    && errorRuntimeFactorIndex.length == 0
                                    && tobeErrorRuntimeFactorIndex.length == 0
                                    && errorDistanceFactorIndex.length == 0
                                    && tobeErrorDistanceFactorIndex.length == 0
                                    && isCreateOrderConfigChanged) {
                                    for (let i = 1; i < configOriginal.createWorkOrder.presets.length; i++) {
                                        for (let j = 1 ; j < configOriginal.createWorkOrder.presets.length - 1; j++) {
                                            const preset1 = configOriginal.createWorkOrder.presets[j];
                                            const preset2 = configOriginal.createWorkOrder.presets[j + 1];
                                            let preset1Duration = preset1.durationFromCreateDate;
                                            switch (preset1.durationFromCreateDateType) {
                                                case 'month': {
                                                    preset1Duration *= 30;
                                                    break;
                                                } case 'year': {
                                                    preset1Duration *= 30 * 12;
                                                    break;
                                                }
                                            }
                                            let preset2Duration = preset2.durationFromCreateDate;
                                            switch (preset2.durationFromCreateDateType) {
                                                case 'month': {
                                                    preset2Duration *= 30;
                                                    break;
                                                } case 'year': {
                                                    preset2Duration *= 30 * 12;
                                                    break;
                                                }
                                            }
                                            if (preset1Duration > preset2Duration) {
                                                let temp = JSON.stringify(preset1);
                                                temp = JSON.parse(temp);
                                                configOriginal.createWorkOrder.presets[j] = JSON.stringify(configOriginal.createWorkOrder.presets[j + 1]);
                                                configOriginal.createWorkOrder.presets[j] = JSON.parse(configOriginal.createWorkOrder.presets[j]);
                                                configOriginal.createWorkOrder.presets[j + 1] = temp;
                                            }
                                        }
                                    }
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
                            isCreateOrderConfigChanged = false;
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
                            checkValidDurationFromCreateDate();
                        }"/>
                        <span v-if="!editingCreateWorkOrderConfig" style="position: relative; top: .5rem;"> {{ configOriginal.createWorkOrder.maximumWorkOrderDurationType }}<span v-if="configOriginal.createWorkOrder.maximumWorkOrderDuration > 1">s</span></span>
                        <span v-if="editingCreateWorkOrderConfig" style="margin-left: .5rem; position: relative; top: .5rem;"> 
                            <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" name="maximumWorkOrderDurationType" :checked="configOriginal.createWorkOrder.maximumWorkOrderDurationType == 'year'" v-on:input="() => {
                                configOriginal.createWorkOrder.maximumWorkOrderDurationType = 'year';
                                checkCreateOrderConfigChanged();
                                checkValidDurationFromCreateDate();
                            }"/> year<span v-if="configOriginal.createWorkOrder.maximumWorkOrderDuration > 1">s</span></label>
                            <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" name="maximumWorkOrderDurationType" :checked="configOriginal.createWorkOrder.maximumWorkOrderDurationType == 'month'" v-on:input="() => {
                                configOriginal.createWorkOrder.maximumWorkOrderDurationType = 'month';
                                checkCreateOrderConfigChanged();
                                checkValidDurationFromCreateDate();
                            }"/> month<span v-if="configOriginal.createWorkOrder.maximumWorkOrderDuration > 1">s</span></label>
                            <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" name="maximumWorkOrderDurationType" :checked="configOriginal.createWorkOrder.maximumWorkOrderDurationType == 'day'" v-on:input="() => {
                                configOriginal.createWorkOrder.maximumWorkOrderDurationType = 'day';
                                checkCreateOrderConfigChanged();
                                checkValidDurationFromCreateDate();
                            }"/> day<span v-if="configOriginal.createWorkOrder.maximumWorkOrderDuration > 1">s</span></label>
                        </span></div>
                    </div>
                    <div>
                        <div style="font-size: .95rem">Equipment sorting presets: <a v-if="editingCreateWorkOrderConfig" v-on:click="() => {
                            checkValidPresetName(1);
                            configOriginal.createWorkOrder.presets.push({
                                name: '',
                                durationFromCreateDate: 0,
                                durationFromCreateDateType: 'day',
                                runtimeFactor: 0.5,
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
                                        errorPresetNameCantBeEmptyIndex = errorPresetNameCantBeEmptyIndex.filter(i => i != index);
                                        errorPresetNameCantBeNormalIndex = errorPresetNameCantBeNormalIndex.filter(i => i != index);
                                        checkValidPresetName(1);
                                        checkCreateOrderConfigChanged();
                                    }"><i class="fa fa-minus-circle"></i> remove</a>
                                </span>
                            </div>
                            <div class="error-text" v-if="errorPresetNameCantBeEmptyIndex.length > 0 || errorPresetNameCantBeNormalIndex.length > 0 || errorPresetNameCantBeNormalIndex.length > 0 || errorPresetNameOfCreateOrderConfigIndex.length > 0">
                                <div v-if="errorPresetNameCantBeEmptyIndex.includes(index)">{{ErrorStrings.ErrorEmptyPresetName}}</div>
                                <div v-else-if="errorPresetNameCantBeNormalIndex.includes(index)">{{ErrorStrings.ErrorPresetNameCantBeNormal}}</div>
                                <div v-else-if="errorPresetNameOfCreateOrderConfigIndex.includes(index) || tobeErrorPresetNameOfCreateOrderConfigIndex.includes(index)">{{ErrorStrings.ErrorPresetNameIsDuplicated}}</div>
                            </div>
                        </div>
                        <div class="is-horizontal" :style="editingCreateWorkOrderConfig ? 'margin: .5rem 0;' : ''">
                            <span v-if="preset.name != 'Normal'" style="position: relative; top: .5rem">- Duration from created date: </span>
                            <!-- <span style="position: relative; top: .5rem" v-if="!editingCreateWorkOrderConfig && preset.durationFromCreateDate > 0"> {{ preset.durationFromCreateDateOperand }}</span>
                            <span style="position: relative; top: .5rem" v-if="editingCreateWorkOrderConfig && preset.durationFromCreateDate > 0">
                                <label class="radio">
                                    <input class="radio" type="radio" :name="'durationFromCreateDateOperand' + index " :checked="preset.durationFromCreateDateOperand == 'before'" v-on:input="() => {
                                        preset.durationFromCreateDateOperand = 'before';
                                        checkCreateOrderConfigChanged();
                                    }"/> before
                                </label>
                                <label class="radio">
                                    <input class="radio" type="radio" :name="'durationFromCreateDateOperand' + index" :checked="preset.durationFromCreateDateOperand == 'from'" v-on:input="() => {
                                        preset.durationFromCreateDateOperand = 'from';
                                        checkCreateOrderConfigChanged();
                                    }"/> from 
                                </label>
                            </span> -->
                            <span style="position: relative; top: .5rem" v-if="!editingCreateWorkOrderConfig && preset.name != 'Normal'"> {{ preset.durationFromCreateDate }}</span>
                            <input style="margin-left: .3rem; width: 7%; text-align: right;" 
                                    :style="errorDurationFromCreateDateIndex.includes(index)
                                            || tobeErrorDurationFromCreateDateIndex.includes(index)
                                            || errorDurationIsGreaterThanMaximumIndex.includes(index) ? 'border: 1px solid var(--danger-color)' : ''"
                                    :disabled="preset.name == 'Normal'"
                                    v-if="editingCreateWorkOrderConfig && preset.name != 'Normal'" v-model.number="preset.durationFromCreateDate" 
                                    class="input" type="number" min="0" step="1" 
                                    v-on:input="() => {
                                if (preset.durationFromCreateDate < 0 || preset.durationFromCreateDate == '') {
                                    preset.durationFromCreateDate = 0;
                                }
                                preset.durationFromCreateDate = parseInt(preset.durationFromCreateDate);
                                checkCreateOrderConfigChanged();
                                checkValidDurationFromCreateDate();
                            }"/>
                            <span style="position: relative; top: .5rem" v-if="!editingCreateWorkOrderConfig && preset.durationFromCreateDate > 0"> {{ preset.durationFromCreateDateType }}<span v-if="preset.durationFromCreateDate > 1">s</span></span>
                            <span v-if="editingCreateWorkOrderConfig && preset.durationFromCreateDate > 0" style="margin-left: .3rem; position: relative; top: .5rem">
                                <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" :name="'durationFromCreateDateType' + index" :checked="preset.durationFromCreateDateType == 'year'" v-on:input="() => {
                                    preset.durationFromCreateDateType = 'year';
                                    checkCreateOrderConfigChanged();
                                    checkValidDurationFromCreateDate();
                                }"/> year<span v-if="preset.durationFromCreateDate > 1">s</span></label>
                                <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" :name="'durationFromCreateDateType' + index" :checked="preset.durationFromCreateDateType == 'month'" v-on:input="() => {
                                    preset.durationFromCreateDateType = 'month';
                                    checkCreateOrderConfigChanged();
                                    checkValidDurationFromCreateDate();
                                }"/> month<span v-if="preset.durationFromCreateDate > 1">s</span></label>
                                <label class="radio"><input style="position: relative; top: .1rem;" class="radio" type="radio" :name="'durationFromCreateDateType' + index" :checked="preset.durationFromCreateDateType == 'day'" v-on:input="() => {
                                    preset.durationFromCreateDateType = 'day';
                                    checkCreateOrderConfigChanged();
                                    checkValidDurationFromCreateDate();
                                }"/> day<span v-if="preset.durationFromCreateDate > 1">s</span></label>
                            </span>
                            <div class="error-text" v-if="errorDurationFromCreateDateIndex.includes(index) || tobeErrorDurationFromCreateDateIndex.includes(index) || errorDurationIsGreaterThanMaximumIndex.includes(index)">
                                <div v-if="errorDurationFromCreateDateIndex.includes(index) || tobeErrorDurationFromCreateDateIndex.includes(index)">{{ ErrorStrings.ErrorConfigDuplicated }}</div>
                                <div v-if="errorDurationIsGreaterThanMaximumIndex.includes(index)">{{ ErrorStrings.ErrorPresetDurationIsGreaterThanMaximum }}</div>
                            </div>
                        </div>
                        <div class="is-horizontal" :style="editingCreateWorkOrderConfig ? 'margin: .5rem 0;' : ''">
                            <span style="position: relative; top: .5rem">- Equipment's runtime duration factor: <span v-if="!editingCreateWorkOrderConfig">{{ preset.runtimeFactor }}</span></span>
                            <input style="width: 7%; text-align: right;" v-if="editingCreateWorkOrderConfig"
                                    :style="errorRuntimeFactorIndex.includes(index) || tobeErrorRuntimeFactorIndex.includes(index) ? 'border: 1px solid var(--danger-color)' : ''"
                                    v-model.number="preset.runtimeFactor" class="input" type="number" 
                                    min="0" max="1" step="0.1" 
                                    v-on:input="() => {
                                if (preset.runtimeFactor < 0 || preset.runtimeFactor == '') {
                                    preset.runtimeFactor = 0;
                                } else if (preset.runtimeFactor > 1) {
                                    preset.runtimeFactor = 1;
                                }
                                preset.runtimeFactor = parseFloat(preset.runtimeFactor.toFixed(2));
                                preset.distanceFactor = parseFloat((1 - preset.runtimeFactor).toFixed(2));
                                checkCreateOrderConfigChanged();
                                checkValidRuntimeFactor();
                            }"/><span style="position: relative; top: .5rem"></span>
                            <div class="error-text" v-if="errorRuntimeFactorIndex.includes(index) || tobeErrorRuntimeFactorIndex.includes(index)">
                                <span>{{ ErrorStrings.ErrorConfigDuplicated }}</span>
                            </div>
                        </div>
                        <div class="is-horizontal" style="margin-bottom: .5rem;">
                            <span style="position: relative; top: .5rem;">- Distance from warehouse factor: <span v-if="!editingCreateWorkOrderConfig">{{ preset.distanceFactor }}</span></span>
                            <input style="width: 7%; text-align: right;" 
                                    :style="errorDistanceFactorIndex.includes(index) || tobeErrorDistanceFactorIndex.includes(index) ? 'border: 1px solid var(--danger-color)' : ''"
                                    v-if="editingCreateWorkOrderConfig" v-model.number="preset.distanceFactor" 
                                    class="input" type="number" min="0" max="1" step="0.1"
                                    v-on:input="() => {
                                if (preset.distanceFactor < 0 || preset.distanceFactor == '') {
                                    preset.distanceFactor = 0;
                                } else if (preset.distanceFactor > 1) {
                                    preset.distanceFactor = 1;
                                }
                                preset.distanceFactor = parseFloat(preset.distanceFactor.toFixed(2));
                                preset.runtimeFactor = parseFloat((1 - preset.distanceFactor).toFixed(2));
                                checkCreateOrderConfigChanged();
                                checkValidDistanceFactor();
                            }"/><span style="position: relative; top: .5rem"></span>
                            <div class="error-text" v-if="errorDistanceFactorIndex.includes(index) || tobeErrorDistanceFactorIndex.includes(index)">
                                <span>{{ ErrorStrings.ErrorConfigDuplicated }}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="configOriginal.nextMaintainYear">
            <div style="font-weight: 500; margin-top: 1rem; font-size: 1.3rem">Editing next maintain year 
                <span style="font-weight: 400; font-size: 1rem;">
                    <a v-if="!editingNextMaintainYearConfig" v-on:click="editingNextMaintainYearConfig = true;"><i class="fa fa-pencil-square-o"></i> edit</a>
                    <span v-if="editingNextMaintainYearConfig">
                        <a :style="!isNextMaintainYearChanged ? 'cursor: not-allowed; color: var(--shadow) !important;' : ''" 
                            v-on:click="() => {
                                if (isNextMaintainYearChanged) {
                                    configCopy = JSON.stringify(configOriginal);
                                    configCopy = JSON.parse(configCopy);
                                    $socket.emit('CONFIGURATION_CHANGED', configOriginal);
                                    editingNextMaintainYearConfig = false;
                                }
                        }">save changes</a> | 
                        <a v-on:click="() => {
                            let configJson = JSON.stringify(configCopy.nextMaintainYear)
                            configOriginal.nextMaintainYear = JSON.parse(configJson);
                            editingNextMaintainYearConfig = false;
                            isNextMaintainYearChanged = false;
                        }">cancel</a>
                    </span>
                </span>
            </div>
            <div v-if="!editingNextMaintainYearConfig" style="display: grid;grid-template-columns: 30% 30%;">
                <div style="padding-top:0.4rem">
                    Maximum duration for next maintaindate: 
                </div>
                <div style="display: grid;grid-template-columns: 10% 20%;">
                    <div  style="padding-top:0.4rem">
                        {{configOriginal.nextMaintainYear.maximumValue}}
                    </div>
                    <div style="padding-top:0.4rem">
                        <label>year(s)</label>
                    </div>
                </div>
            </div>
            <div v-if="editingNextMaintainYearConfig" style="display: grid;grid-template-columns: 30% 30%;">
                <div style="padding-top:0.4rem">
                    Maximum duration for next maintaindate: 
                </div>
                <div style="display: grid;grid-template-columns: 30% 20%;">
                    <div>
                        <input type="number"  class="input" v-model.number="configOriginal.nextMaintainYear.maximumValue" v-on:input="() => {
                            if (configOriginal.nextMaintainYear.maximumValue < 0 || configOriginal.nextMaintainYear.maximumValue == '') {
                                configOriginal.nextMaintainYear.maximumValue = 0;
                            }
                            configOriginal.nextMaintainYear.maximumValue = parseInt(configOriginal.nextMaintainYear.maximumValue);
                            checkNextMaintainDateConfigChanged();
                        }"/>
                    </div>
                    <div style="padding-top:0.4rem">
                        <label>year(s)</label>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="configOriginal.warrantyMonth">
            <div style="font-weight: 500; margin-top: 1rem; font-size: 1.3rem">Editing maximum value of warranty (months) 
                <span style="font-weight: 400; font-size: 1rem;">
                    <a v-if="!editingWarrantyMonthConfig" v-on:click="editingWarrantyMonthConfig = true;"><i class="fa fa-pencil-square-o"></i> edit</a>
                    <span v-if="editingWarrantyMonthConfig">
                        <a :style="!isWarrantyMonthChanged ? 'cursor: not-allowed; color: var(--shadow) !important;' : ''" 
                            v-on:click="() => {
                                if (isWarrantyMonthChanged) {
                                    configCopy = JSON.stringify(configOriginal);
                                    configCopy = JSON.parse(configCopy);
                                    $socket.emit('CONFIGURATION_CHANGED', configOriginal);
                                    editingWarrantyMonthConfig = false;
                                }
                        }">save changes</a> | 
                        <a v-on:click="() => {
                            let configJson = JSON.stringify(configCopy.warrantyMonth)
                            configOriginal.warrantyMonth = JSON.parse(configJson);
                            editingWarrantyMonthConfig = false;
                            isWarrantyMonthChanged = false;
                        }">cancel</a>
                    </span>
                </span>
            </div>
            <div v-if="!editingWarrantyMonthConfig" style="display: grid;grid-template-columns: 24% 30%;">
                <div style="padding-top:0.4rem">
                    Maximum value for warranty: 
                </div>
                <div style="display: grid;grid-template-columns: 10% 20%;">
                    <div  style="padding-top:0.4rem">
                        {{configOriginal.warrantyMonth.maximumValue}}
                    </div>
                    <div style="padding-top:0.4rem">
                        <label>month(s)</label>
                    </div>
                </div>
            </div>
            <div v-if="editingWarrantyMonthConfig" style="display: grid;grid-template-columns: 24% 30%;">
                <div style="padding-top:0.4rem">
                    Maximum value for warranty: 
                </div>
                <div style="display: grid;grid-template-columns: 30% 20%;">
                    <div>
                        <input type="number"  class="input" v-model.number="configOriginal.warrantyMonth.maximumValue" v-on:input="() => {
                            if (configOriginal.warrantyMonth.maximumValue < 0 || configOriginal.warrantyMonth.maximumValue == '') {
                                configOriginal.warrantyMonth.maximumValue = 0;
                            }
                            configOriginal.warrantyMonth.maximumValue = parseInt(configOriginal.warrantyMonth.maximumValue);
                            checkWarrantyMonthConfigChanged();
                        }"/>
                    </div>
                    <div style="padding-top:0.4rem">
                        <label>month(s)</label>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="configOriginal.numOfAddItem">
            <div style="font-weight: 500; margin-top: 1rem; font-size: 1.3rem">Editing maximum value when add items 
                <span style="font-weight: 400; font-size: 1rem;">
                    <a v-if="!editingNumOfAddItemConfig" v-on:click="editingNumOfAddItemConfig = true;"><i class="fa fa-pencil-square-o"></i> edit</a>
                    <span v-if="editingNumOfAddItemConfig">
                        <a :style="!isNumOfAddItemChanged ? 'cursor: not-allowed; color: var(--shadow) !important;' : ''" 
                            v-on:click="() => {
                                if (isNumOfAddItemChanged) {
                                    configCopy = JSON.stringify(configOriginal);
                                    configCopy = JSON.parse(configCopy);
                                    $socket.emit('CONFIGURATION_CHANGED', configOriginal);
                                    editingNumOfAddItemConfig = false;
                                }
                        }">save changes</a> | 
                        <a v-on:click="() => {
                            let configJson = JSON.stringify(configCopy.numOfAddItem)
                            configOriginal.numOfAddItem = JSON.parse(configJson);
                            editingNumOfAddItemConfig = false;
                            isNumOfAddItemChanged = false;
                        }">cancel</a>
                    </span>
                </span>
            </div>
            <div v-if="!editingNumOfAddItemConfig" style="display: grid;grid-template-columns: 24% 30%;">
                <div style="padding-top:0.4rem">
                    Maximum value for add item: 
                </div>
                <div style="display: grid;grid-template-columns: 10% 20%;">
                    <div  style="padding-top:0.4rem">
                        {{configOriginal.numOfAddItem.maximumValue}}
                    </div>
                </div>
            </div>
            <div v-if="editingNumOfAddItemConfig" style="display: grid;grid-template-columns: 24% 30%;">
                <div style="padding-top:0.4rem">
                   Maximum value for add item:
                </div>
                <div style="display: grid;grid-template-columns: 30% 20%;">
                    <div>
                        <input type="number"  class="input" v-model.number="configOriginal.numOfAddItem.maximumValue" v-on:input="() => {
                            if (configOriginal.numOfAddItem.maximumValue < 1 || configOriginal.numOfAddItem.maximumValue == '') {
                                configOriginal.numOfAddItem.maximumValue = 1;
                            }
                            configOriginal.numOfAddItem.maximumValue = parseInt(configOriginal.numOfAddItem.maximumValue);
                            checkNumOfAddItemConfigChanged();
                        }"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { sync } from "vuex-pathify";

export default {
  computed: {
    config: sync("config")
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
        ErrorPresetNameCantBeNormal: 'Preset\'s name can not be "Normal"',
        ErrorEmptyPresetName: "Preset's name can not be empty",
        ErrorPresetNameIsDuplicated:
          "This name is duplicated with other presets",
        ErrorConfigDuplicated:
          "Configuration is duplicated, it may cause unexpected result of the sorting algorithm",
        ErrorPresetDurationIsGreaterThanMaximum:
          "The work order duration is greater than the maximum duration"
      },
      CreateOrderErrors: {
        ErrorPresetNameCantBeNormal: "",
        ErrorEmptyPresetName: "",
        ErrorPresetNameIsDuplicated: ""
      },
      configOriginal: null,
      configCopy: null,
      errorPresetNameCantBeEmptyIndex: [],
      errorPresetNameCantBeNormalIndex: [],
      errorPresetNameOfCreateOrderConfigIndex: [],
      tobeErrorPresetNameOfCreateOrderConfigIndex: [],
      errorDurationFromCreateDateIndex: [],
      tobeErrorDurationFromCreateDateIndex: [],
      errorRuntimeFactorIndex: [],
      tobeErrorRuntimeFactorIndex: [],
      errorDistanceFactorIndex: [],
      tobeErrorDistanceFactorIndex: [],
      errorDurationIsGreaterThanMaximumIndex: [],
      isCreateOrderConfigChanged: false,
      editingCreateWorkOrderConfig: false,
      editingNextMaintainYearConfig: false,
      isNextMaintainYearChanged: false,
      editingWarrantyMonthConfig: false,
      isWarrantyMonthChanged: false,
      editingNumOfAddItemConfig: false,
      isNumOfAddItemChanged: false
    };
  },
  watch: {
    config: function() {
      if (this.config) {
        let configJson = JSON.stringify(this.config);
        this.configOriginal = JSON.parse(configJson);
        this.configCopy = JSON.parse(configJson);
      }
    }
  },
  methods: {
    checkValidPresetName() {
      let presets = this.configOriginal.createWorkOrder.presets;
      for (let i = 1; i < presets.length; i++) {
        if (presets[i].name == "") {
          this.errorPresetNameCantBeEmptyIndex.push(i);
        } else {
          if (this.errorPresetNameCantBeEmptyIndex.includes(i)) {
            this.errorPresetNameCantBeEmptyIndex = this.errorPresetNameCantBeEmptyIndex.filter(
              index => i != index
            );
          }
          if (presets[i].name.toLowerCase() == "normal") {
            if (!this.errorPresetNameCantBeNormalIndex.includes(i)) {
              this.errorPresetNameCantBeNormalIndex.push(i);
            }
          } else {
            if (this.errorPresetNameCantBeNormalIndex.includes(i)) {
              this.errorPresetNameCantBeNormalIndex = this.errorPresetNameCantBeNormalIndex.filter(
                index => i != index
              );
            }
            this.errorPresetNameOfCreateOrderConfigIndex = [];
            this.tobeErrorPresetNameOfCreateOrderConfigIndex = [];
            for (
              let j = i + 1;
              j < presets.length && i < presets.length - 1;
              j++
            ) {
              let toCheckPreset = presets[i];
              let tobeCheckedPreset = presets[j];
              if (
                toCheckPreset.name.toLowerCase() ==
                tobeCheckedPreset.name.toLowerCase()
              ) {
                if (!this.errorPresetNameOfCreateOrderConfigIndex.includes(i)) {
                  this.errorPresetNameOfCreateOrderConfigIndex.push(i);
                }
                if (
                  !this.tobeErrorPresetNameOfCreateOrderConfigIndex.includes(j)
                ) {
                  this.tobeErrorPresetNameOfCreateOrderConfigIndex.push(j);
                }
              }
            }
          }
        }
      }
    },
    checkValidDurationFromCreateDate() {
      let maximumDuration = this.configOriginal.createWorkOrder
        .maximumWorkOrderDuration;
      switch (this.configOriginal.createWorkOrder
        .maximumWorkOrderDurationType) {
        case "month": {
          maximumDuration *= 30;
          break;
        }
        case "year": {
          maximumDuration *= 30 * 12;
          break;
        }
      }
      const presets = this.configOriginal.createWorkOrder.presets;
      this.errorDurationIsGreaterThanMaximumIndex = [];
      this.errorDurationFromCreateDateIndex = [];
      this.tobeErrorDurationFromCreateDateIndex = [];
      for (let i = 0; i < presets.length; i++) {
        let presetDuration = presets[i].durationFromCreateDate;
        switch (presets[i].durationFromCreateDateType) {
          case "month": {
            presetDuration *= 30;
            break;
          }
          case "year": {
            presetDuration *= 30 * 12;
            break;
          }
        }
        if (presetDuration > maximumDuration) {
          this.errorDurationIsGreaterThanMaximumIndex.push(i);
        }
        for (let j = 0; j < presets.length; j++) {
          if (i != j) {
            const toCheckPreset = presets[i];
            const tobeCheckedPreset = presets[j];
            if (
              toCheckPreset.durationFromCreateDate ==
                tobeCheckedPreset.durationFromCreateDate &&
              toCheckPreset.durationFromCreateDateType ==
                tobeCheckedPreset.durationFromCreateDateType
            ) {
              if (!this.errorDurationFromCreateDateIndex.includes(i)) {
                this.errorDurationFromCreateDateIndex.push(i);
              }
              if (!this.tobeErrorDurationFromCreateDateIndex.includes(j)) {
                this.tobeErrorDurationFromCreateDateIndex.push(j);
              }
            }
          }
        }
      }
    },
    checkValidRuntimeFactor() {
      const presets = this.configOriginal.createWorkOrder.presets;
      this.errorDistanceFactorIndex = [];
      this.tobeErrorDistanceFactorIndex = [];
      this.errorRuntimeFactorIndex = [];
      this.tobeErrorRuntimeFactorIndex = [];
      for (let i = 0; i < presets.length; i++) {
        for (let j = 0; j < presets.length; j++) {
          if (i != j) {
            const toCheckPreset = presets[i];
            const tobeCheckedPreset = presets[j];
            if (
              toCheckPreset.runtimeFactor == tobeCheckedPreset.runtimeFactor
            ) {
              if (!this.errorRuntimeFactorIndex.includes(i)) {
                this.errorRuntimeFactorIndex.push(i);
              }
              if (!this.tobeErrorRuntimeFactorIndex.includes(j)) {
                this.tobeErrorRuntimeFactorIndex.push(j);
              }
            }
          }
        }
      }
    },
    checkValidDistanceFactor() {
      const presets = this.configOriginal.createWorkOrder.presets;
      this.errorDistanceFactorIndex = [];
      this.tobeErrorDistanceFactorIndex = [];
      this.errorRuntimeFactorIndex = [];
      this.tobeErrorRuntimeFactorIndex = [];
      for (let i = 0; i < presets.length; i++) {
        for (let j = 0; j < presets.length; j++) {
          if (i != j) {
            const toCheckPreset = presets[i];
            const tobeCheckedPreset = presets[j];
            if (
              toCheckPreset.distanceFactor == tobeCheckedPreset.distanceFactor
            ) {
              if (!this.errorDistanceFactorIndex.includes(i)) {
                this.errorDistanceFactorIndex.push(i);
              }
              if (!this.tobeErrorDistanceFactorIndex.includes(j)) {
                this.tobeErrorDistanceFactorIndex.push(j);
              }
            }
          }
        }
      }
    },
    checkNumOfAddItemConfigChanged() {
      this.isNumOfAddItemChanged = false;

      const numOfAddItemConfigOriginal = this.configOriginal
        .numOfAddItem;
      const numOfAddItemConfigCopy = this.configCopy.numOfAddItem;
      if (
        this.configOriginal.numOfAddItem.maximumValue !=
        numOfAddItemConfigCopy.maximumValue
      ) {
        this.isNumOfAddItemChanged = true;
      }
    },
    checkWarrantyMonthConfigChanged() {
      this.isWarrantyMonthChanged = false;

      const warrantyMonthConfigOriginal = this.configOriginal
        .warrantyMonth;
      const warrantyMonthConfigCopy = this.configCopy.warrantyMonth;
      if (
        this.configOriginal.warrantyMonth.maximumValue !=
        warrantyMonthConfigCopy.maximumValue
      ) {
        this.isWarrantyMonthChanged = true;
      }
    },
    checkNextMaintainDateConfigChanged() {
      this.isNextMaintainYearChanged = false;

      const nextMaintainYearConfigOriginal = this.configOriginal
        .nextMaintainYear;
      const nextMaintainYearConfigCopy = this.configCopy.nextMaintainYear;
      if (
        this.configOriginal.nextMaintainYear.maximumValue !=
        nextMaintainYearConfigCopy.maximumValue
      ) {
        this.isNextMaintainYearChanged = true;
      }
    },
    checkCreateOrderConfigChanged() {
      this.isCreateOrderConfigChanged = false;
      const createWorkOrderConfigOriginal = this.configOriginal.createWorkOrder;
      const createWorkOrderConfigCopy = this.configCopy.createWorkOrder;
      if (createWorkOrderConfigOriginal && createWorkOrderConfigCopy) {
        this.isCreateOrderConfigChanged =
          createWorkOrderConfigOriginal.maximumConflictWorkOrders !=
            createWorkOrderConfigCopy.maximumConflictWorkOrders ||
          createWorkOrderConfigOriginal.maximumWorkOrderDuration !=
            createWorkOrderConfigCopy.maximumWorkOrderDuration ||
          createWorkOrderConfigOriginal.maximumWorkOrderDurationType !=
            createWorkOrderConfigCopy.maximumWorkOrderDurationType;
        if (!this.isCreateOrderConfigChanged) {
          for (
            let i = 0;
            i < createWorkOrderConfigOriginal.presets.length;
            i++
          ) {
            if (
              createWorkOrderConfigOriginal.presets.length ==
              createWorkOrderConfigCopy.presets.length
            ) {
              const createWorkOrderConfigOriginalPreset =
                createWorkOrderConfigOriginal.presets[i];
              const createWorkOrderConfigCopyPreset =
                createWorkOrderConfigCopy.presets[i];
              this.isCreateOrderConfigChanged =
                createWorkOrderConfigOriginalPreset.durationFromCreateDate !=
                  createWorkOrderConfigCopyPreset.durationFromCreateDate ||
                createWorkOrderConfigOriginalPreset.durationFromCreateDateType !=
                  createWorkOrderConfigCopyPreset.durationFromCreateDateType ||
                createWorkOrderConfigOriginalPreset.durationFromCreateDateOperand !=
                  createWorkOrderConfigCopyPreset.durationFromCreateDateOperand ||
                createWorkOrderConfigOriginalPreset.runtimeFactor !=
                  createWorkOrderConfigCopyPreset.runtimeFactor ||
                createWorkOrderConfigOriginalPreset.distanceFactor !=
                  createWorkOrderConfigCopyPreset.distanceFactor;
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
};
</script>

<style scoped>
</style>
