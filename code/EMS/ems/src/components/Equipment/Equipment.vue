<template>
    <div>
        <h3>Equipment table</h3>

        <!-- <div class="cards-wrapper">
            <equipment-card name='Hammer' imageUrl='https://images.homedepot-static.com/productImages/25cf424d-4d30-4cf1-a370-4053f2cca3e7/svn/dewalt-specialty-hammers-dwht51138x-64_1000.jpg'></equipment-card>
            <equipment-card name='Hammer' imageUrl='https://images.homedepot-static.com/productImages/25cf424d-4d30-4cf1-a370-4053f2cca3e7/svn/dewalt-specialty-hammers-dwht51138x-64_1000.jpg'></equipment-card>
            <equipment-card name='Hammer' imageUrl='https://images.homedepot-static.com/productImages/25cf424d-4d30-4cf1-a370-4053f2cca3e7/svn/dewalt-specialty-hammers-dwht51138x-64_1000.jpg'></equipment-card>
            <equipment-card name='Hammer' imageUrl='https://images.homedepot-static.com/productImages/25cf424d-4d30-4cf1-a370-4053f2cca3e7/svn/dewalt-specialty-hammers-dwht51138x-64_1000.jpg'></equipment-card>
            
        </div> -->
        <div class="equipment-block">
       <div class="field is-grouped" >
            <button id="btn-table-view" disabled="disabled">Table view</button>
            <a href="/equipment/card"><button id="btn-card-view" >Card view</button></a>


        </div>
        
        </div>

<table class="table">
  <thead>
    <tr>
      <th><abbr title="Position"> <strong>ID</strong> </abbr></th>
      <th> <strong> Name </strong> </th>
      <th><abbr title="Played"><strong>Location </strong></abbr></th>
      <th><abbr title="Won"> <strong>Model</strong> </abbr></th>
      <th><abbr title="Drawn"> <strong>Barcode</strong> </abbr></th>
      <th><abbr title="Lost"> <strong>Area</strong> </abbr></th>
      <th><abbr title="Goals for"> <strong> Asset category</strong></abbr></th>
      <th><abbr title="Goals against"> <strong>Description</strong> </abbr></th>
      <th><abbr title="Goal difference"> <strong>Parent asset</strong> </abbr></th>
      <th><abbr title="Points"> <strong> Date added </strong> </abbr></th>

    </tr>
  </thead>
  <!-- <tfoot>
    <tr>
      <th><abbr title="Position">ID</abbr></th>
      <th>Name</th>
      <th><abbr title="Played">Location</abbr></th>
      <th><abbr title="Won">Model</abbr></th>
      <th><abbr title="Drawn">Barcode</abbr></th>
      <th><abbr title="Lost">Area</abbr></th>
      <th><abbr title="Goals for">Asset category</abbr></th>
      <th><abbr title="Goals against">Description</abbr></th>
      <th><abbr title="Goal difference">Parent asset</abbr></th>
      <th><abbr title="Points">Date added</abbr></th>
    </tr>
  </tfoot> -->
  <tbody>
    <tr>
      <th>1</th>
      <td>Crane</td>
      <td>Phu Dong Thien Vuong</td>
      <td>CRA5273</td>
      <td>1234789657821</td>
      <td>3</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>
     
    </tr>
    <tr>
      <th>2</th>
      <td>Truck</td>
      <td>01 Tan thoi Hiep,Q12</td>
      <td>CRA5273</td>
      <td>1234789657231</td>
      <td>6</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>
     
    </tr>
    <tr>
      <th>3</th>
      <td>Truck</td>
      <td>81 Tan thoi Hiep,Q12</td>
      <td>TRU5273</td>
      <td>1234789655398</td>
      <td>7</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>
      
    </tr>
    <tr class="is-selected">
      <th>4</th>
      <td>Crane</td>
      <td>Phu Dong Thien Vuong</td>
      <td>CRA5273</td>
      <td>1234789657821</td>
      <td>3</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>
    
    </tr>
    <tr>
      <th>5</th>
      <td>Crane</td>
      <td>Phu Dong Thien Vuong</td>
      <td>CRA5273</td>
      <td>1234789657821</td>
      <td>3</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>
    
    </tr>
    <tr>
      <th>6</th>
      <td>Crane</td>
      <td>Phu Dong Thien Vuong</td>
      <td>CRA5273</td>
      <td>1234789657821</td>
      <td>3</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>
     
    </tr>
    <tr>
      <th>7</th>
     <td>Crane</td>
      <td>Phu Dong Thien Vuong</td>
      <td>CRA5273</td>
      <td>1234789657821</td>
      <td>3</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>
     
    </tr>
    <tr>
      <th>8</th>
      <td>Crane</td>
      <td>Phu Dong Thien Vuong</td>
      <td>CRA5273</td>
      <td>1234789657821</td>
      <td>3</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>

    </tr>
    <tr>
      <th>9</th>
     <td>Crane</td>
      <td>Phu Dong Thien Vuong</td>
      <td>CRA5273</td>
      <td>1234789657821</td>
      <td>3</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>

    </tr>
    <tr>
      <th>10</th>
      <td>Crane</td>
      <td>Phu Dong Thien Vuong</td>
      <td>CRA5273</td>
      <td>1234789657821</td>
      <td>3</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>22/03/2015</td>

    </tr>
<button id="btn-add-equipment">Add Equipment</button>
  </tbody>
</table>


    </div>
</template>

<script>
import EquipmentCard from "./EquipmentCard";

export default {
  components: {
    EquipmentCard
  }
};
</script>

<style>
.cards-wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
}
#field1 {
  background-color: white;
}
#btn-add-equipment {
  position: fixed;
  right: 3rem;
  bottom: 2rem;
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 10px;
  box-shadow: 4px 4px 5px #bdbdbd;
  z-index: 1;
}

#btn-add-equipment:hover {
  cursor: pointer;
  background-color: #009688;
  color: white;
}
#btn-table-view {
  background-color: white;
  padding: 4px;
  height: 30px;
  font-size: 15px;
  line-height: 15px;
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;

  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
  padding-left: 20px; */
  margin-right: 5px; 
}
#btn-table-view:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
#btn-table-view:disabled {
  background-color: #26a69a;
  color: white;
  cursor: no-drop;
}

#btn-card-view {
  background-color: white;
  padding: 4px;
  height: 30px;
  font-size: 15px;
  line-height: 15px;
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #26a69a;
  z-index: 1;

}
#btn-card-view:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
#btn-card-view:disabled {
  background-color: #26a69a;
  color: white;
  cursor: no-drop;
}
.equipment-block {
  display: grid;
  grid-template-columns: 80% 20%;
  grid-template-rows: 1 1 1;
  background-color: #fafafa;
  border-radius: 3px;
  padding: 0.3rem 1rem;
  box-shadow: 3px 3px 5px #bdbdbd;
  margin: 2rem 5rem;
}

</style>
