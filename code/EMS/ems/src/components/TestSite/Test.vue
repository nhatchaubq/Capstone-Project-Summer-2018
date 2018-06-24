<template>
    <div>
        Upload an image...
        <file-base64 :done="getFile"></file-base64>
        <!-- <img ref="myImage" draggable="false" :src="image.base64" :alt="image.name" v-if="image"> -->
        <div v-if="file">
            <div>
                Draw grid:
                <label class="radio">
                    <input name="gridmode" v-on:click="gridPresetMode = true" checked type="radio">
                    Preset
                </label>
                <label class="radio">
                    <input name="gridmode" v-on:click="gridPresetMode = false" type="radio">
                    By hand
                </label>
            </div>
            <div class="select" v-if="gridPresetMode">
                <select v-model="selectedGridPreset">
                    <option value="null" disabled selected="true">Select a preset</option>
                    <option :value="{column: 3, row: 2}">3 x 2</option>
                    <option :value="{column: 3, row: 3}">3 x 3</option>
                    <option :value="{column: 6, row: 2}">6 x 2</option>
                    <option :value="{column: 6, row: 3}">6 x 3</option>
                </select>
            </div>
        </div>
        <div style="max-width: 70%">
            <canvas style="cursor: pointer;" ref="myCanvas"></canvas>            
            <div v-if="!gridPresetMode">
                <button class="button" :disabled="currentPoly.points.length == 0" v-on:click="() => {
                    currentPoly.points.pop(); 
                    if(currentPoly.points.length > 0) {
                        drawPoints();
                    } else {
                        clearStrokes();
                    }
                }">Undo</button>
                <button class="button" :disabled="selectingPointIndex == -1" v-on:click="() => {
                    currentPoly.points.splice(selectingPointIndex, 1); 
                    if(currentPoly.points.length > 0) {
                        drawPoints();
                    } else {
                        clearStrokes();
                    }
                    selectingPointIndex = -1;
                }">Remove</button>
                <button class="button" :disabled="currentPoly.points.length == 0 || polyList.length == 0" v-on:click="() => {
                    currentPoly = {name: '', points: []};    
                    polyList = [];
                    selectingPointIndex = -1;
                    clearStrokes();
                }">Remove All</button>
                <div>
                    <div class="field is-horizontal">
                        <label>Tile name: </label>
                        <input type="text" class="input" v-model="currentPoly.name">
                    </div>
                    <button class="button" :disabled="currentPoly.points.length < 2" v-on:click="() => {
                        polyList.push(currentPoly);
                        currentPoly = {name: '', points: []};
                        selectingPointIndex = -1;
                        drawPoints();
                    }">Save tile</button>
                    <div>
                        <button class="button" v-on:click="() => {                            
                            showAlert(JSON.stringify(polyList));
                        }">Finish</button>
                    </div>
                </div>
            </div>
        </div>        
    </div>
</template>

<script>
import fileBase64 from 'vue-file-base64';

export default {
    components: {
        fileBase64,
    },
    data() {
        return {
            file: null,
            background: null,
            selectedGridPreset: null,
            selectedTile: null,
            strokes: [],
            gridPresetMode: true,
            currentPoly: {
                name: '',
                points: [],
            },
            polyList: [],
            radius: 5,
            canvasMouseDown: false,
            selectingPointIndex: -1,
        }
    },
    mounted() {
        let context = this;
        let canvas = this.$refs.myCanvas;
        // let canvasContext = this.$refs.myCanvas.getContext('2d');
        canvas.addEventListener('mousemove', (event) => {
            var mousePos = {
                x: event.clientX - canvas.getBoundingClientRect().left,
                y: event.clientY - canvas.getBoundingClientRect().top
            };
            context.drawStrokes(mousePos.x, mousePos.y);
        });
        canvas.addEventListener('mousedown', (event) => {
            context.canvasMouseDown = true;
            var mousePos = {
                x: event.clientX - canvas.getBoundingClientRect().left,
                y: event.clientY - canvas.getBoundingClientRect().top
            };
            if (!context.gridPresetMode) {
                for (var i = 0; i < context.currentPoly.points.length; i++) {
                    let point = context.currentPoly.points[i];
                    let distX = mousePos.x - point.x;
                    let distY = mousePos.y - point.y;
                    let distance = Math.sqrt((distX * distX) + (distY * distY));
                    if (distance <= context.radius) {
                        context.selectingPointIndex = i;
                        break;
                    } else {
                        context.selectingPointIndex = -1;
                    }
                }
                if (context.selectingPointIndex == -1) {
                    context.tileClick(mousePos.x, mousePos.y);
                }
            }
        });
        canvas.addEventListener('mouseup', (event) => {
            context.canvasMouseDown = false;
            if (!context.gridPresetMode && (context.currentPoly.points.length > 0 || context.polyList.length > 0)) {
                // context.selectingPointIndex = -1;
                context.drawPoints();
            }
        });
        canvas.addEventListener('click', (event) => {
            if (context.gridPresetMode) {
                var mousePos = {
                    x: event.clientX - canvas.getBoundingClientRect().left,
                    y: event.clientY - canvas.getBoundingClientRect().top
                };
                context.tileClick(mousePos.x, mousePos.y);
            }
        });
    },
    methods: {
        showAlert(msg) {
            alert(msg);
        },
        getFile(file) {
            console.log(file);
            // this.image = file;
            this.file = file;
            let canvas = this.$refs.myCanvas;
            let canvasContext = canvas.getContext('2d');
            this.background = new Image();
            this.background.src = file.base64;
            this.background.onload = () => {
                canvas.width = this.background.width;
                canvas.height = this.background.height;
                canvasContext.drawImage(this.background, 0, 0);
            };
        },
        showDimensions() {
            let img = this.$refs.myImage;
            alert(`${img.naturalWidth} x ${img.naturalHeight}`)
        },
        clearStrokes() {
            let canvas = this.$refs.myCanvas;
            let canvasContext = this.$refs.myCanvas.getContext('2d');
            canvasContext.clearRect(0, 0, canvas.width, canvas.height);
            canvasContext.drawImage(this.background, 0, 0);
            // canvasContext.beginPath();
            // canvasContext.moveTo(0,0);
            // canvasContext.stroke();
        },
        drawStrokes(mouseX, mouseY) {
            if (this.file) {                
                let canvas = this.$refs.myCanvas;
                let canvasContext = canvas.getContext('2d');    

                if (this.gridPresetMode && this.selectedGridPreset) {
                    let tileWidth = canvas.width / this.selectedGridPreset.column;
                    let tileHeight = canvas.height / this.selectedGridPreset.row;
                    this.clearStrokes();
                    for (var row = 0; row < this.selectedGridPreset.row; row++) {
                        for (var col = 0; col < this.selectedGridPreset.column; col++) {
                            let x = col * canvas.width / this.selectedGridPreset.column;
                            let y = row * canvas.height / this.selectedGridPreset.row;
              
                            canvasContext.beginPath();
                            canvasContext.strokeStyle = "rgba(0,0,0,0.6)";
                            canvasContext.lineWidth = '2';
                            canvasContext.font = '2rem Roboto';
                            canvasContext.fillStyle = "black";
                            let tileOrderNumber = (col + 1) + (row * this.selectedGridPreset.column);
                            canvasContext.fillText(`${tileOrderNumber}`, (x + tileWidth / 2) - 10, y + tileHeight / 2);
                            if ((mouseX && mouseY) && (mouseX >= x && mouseX <= (x + tileWidth) 
                                                            && (mouseY >= y && mouseY <= (y + tileHeight)))) {
                                // canvasContext.strokeStyle = "red";
                                // canvasContext.lineWidth = "2";
                                canvasContext.fillStyle = 'rgba(255,0,0,0.4)';
                            } else {
                                canvasContext.lineWidth = "1";
                                canvasContext.fillStyle = 'rgba(0,0,0,0.1)';
                            }
                                // canvasContext.strokeStyle = "black";
                            // this.strokes.push({
                            //     id: tileOrderNumber,
                            //     name: tileOrderNumber,
                            //     x: x,
                            //     y: y,
                            //     width: tileWidth,
                            //     height: tileHeight,
                            // });
                            canvasContext.rect(x, y, tileWidth, tileHeight);
                            canvasContext.fillRect(x, y, tileWidth, tileHeight);
                            canvasContext.stroke();
                        }
                    }
                } 
                else if (this.canvasMouseDown && this.selectingPointIndex >= 0) {
                    this.clearStrokes();
                    this.currentPoly.points[this.selectingPointIndex].x = mouseX;
                    this.currentPoly.points[this.selectingPointIndex].y = mouseY;
                    this.drawPoints();
                }
            }
        },
        drawPoints() {
            this.clearStrokes();
            if (this.currentPoly.points.length > 0) {
                this.drawPoly(this.currentPoly, true);
            }
            this.polyList.forEach(poly => {
                this.drawPoly(poly, false);
            });
            
        },
        drawPoly(poly, drawPoints) {
            // this.clearStrokes();
            let canvasContext = this.$refs.myCanvas.getContext('2d');
            if (poly.points.length > 0) {
                canvasContext.fillStyle = 'rgba(255,0,0,0.4)';
                if (drawPoints) {
                    poly.points.forEach(point => {
                        canvasContext.beginPath();
                        canvasContext.arc(point.x, point.y, this.radius, 0, 2 * Math.PI, false);
                        canvasContext.closePath();
                        canvasContext.fill();
                    });
                }
                canvasContext.beginPath();
                canvasContext.moveTo(poly.points[0].x, poly.points[0].y);
                let minX = poly.points[0].x;
                let maxX = poly.points[0].x;
                let minY = poly.points[0].y;
                let maxY = poly.points[0].y;
                for(var index = 1; index < poly.points.length; index++) {
                    canvasContext.lineTo(poly.points[index].x, poly.points[index].y); 
                    if (poly.name.length > 0) {
                        if (poly.points[index].x < minX) {
                            minX = poly.points[index].x;
                        }
                        if (poly.points[index].x > maxX) {
                            maxX = poly.points[index].x;
                        }
                        if (poly.points[index].y < minY) {
                            minY = poly.points[index].y;
                        }
                        if (poly.points[index].y > maxY) {
                            maxY = poly.points[index].y;
                        }
                    }                
                }
                canvasContext.closePath();
                canvasContext.fill();
                if (poly.name.length > 0) {
                    canvasContext.strokeStyle = "rgba(0,0,0,0.6)";
                    canvasContext.lineWidth = '2';
                    canvasContext.font = '2rem Roboto';
                    canvasContext.fillStyle = "black";
                    canvasContext.textAlign = 'center';
                    canvasContext.fillText(`${poly.name}`, (minX + maxX) / 2, (maxY + minY) / 2);
                }
            }
        },
        tileClick(mouseX, mouseY) {
            if (this.file) {
                let canvas = this.$refs.myCanvas;
                // let canvasContext = canvas.getContext('2d');    
                if (this.gridPresetMode && this.selectedGridPreset) {      
                    // this.clearStrokes();          
                    let tileWidth = canvas.width / this.selectedGridPreset.column;
                    let tileHeight = canvas.height / this.selectedGridPreset.row;
                    for (var row = 0; row < this.selectedGridPreset.row; row++) {
                        for (var col = 0; col < this.selectedGridPreset.column; col++) {
                            let x = col * canvas.width / this.selectedGridPreset.column;
                            let y = row * canvas.height / this.selectedGridPreset.row;
              
                            let tileOrderNumber = (col + 1) + (row * this.selectedGridPreset.column);
    
                            if ((mouseX && mouseY) && (mouseX >= x && mouseX <= (x + tileWidth) 
                                                            && (mouseY >= y && mouseY <= (y + tileHeight)))) {
                                alert(`Tile number ${tileOrderNumber}`);                                
                            }
                        }
                    }
                } else if (!this.gridPresetMode) {                
                    this.currentPoly.points.push({x: mouseX, y: mouseY});     
                }
            }
        }
    },
    watch: {
        // 'image': function() {
        //     this.$refs.myCanvas.style.height = this.$refs.myImage.naturalHeight;
        //     this.$refs.myCanvas.style.widht = this.$refs.myImage.naturalWidth;
        // }
        file: function() {
            this.selectedGridPreset = null;
            // let canvas = this.$refs.myCanvas;
            // let canvasContext = canvas.getContext('2d');
            // this.background = new Image();
            // this.background.src = this.file.base64;
            // this.background.onload = () => {
            //     canvasContext.drawImage(this.background, 0, 0);
            // }
        },
        selectedGridPreset: function() {
            if (this.selectedGridPreset) {
                this.drawStrokes(null, null);
            }
        },
        gridPresetMode: function() {
            this.clearStrokes();
            if (this.gridPresetMode && this.selectedGridPreset) {
                this.drawStrokes(null, null);
            } else if (!this.gridPresetMode && this.currentPoly.points.length > 0) {
                this.drawPoints();
            }
        },
        'currentPoly.name': function() {
            this.drawPoints();
        }
    }
}
</script>

<style>

</style>
