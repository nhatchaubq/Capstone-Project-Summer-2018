<template>
    <div>
      <div class="equipment-block">
       <div class="field is-grouped" >
            <button id="btn-table-view" disabled="disabled">Table view</button>
            <a href="/equipment/card"><button id="btn-card-view" >Card view</button></a>
        </div>
      </div>
      <div style="overflow-x:auto;overflow-y:auto">
  <table>
    <tr>
      <th> <strong> ID </strong> </th>
      <th> <strong> Name </strong> </th>
      <th> <strong> Vendor's name </strong> </th>
      <th> <strong> Import's date </strong> </th>
      <th> <strong> Price </strong> </th>
      <th> <strong> Description </strong> </th>
      <th> <strong> Category </strong> </th>
      <th> <strong> In department </strong> </th>
 
    </tr>
    <tr class="tr1">
      <td>1</td>
      <td>Truck 2753</td>
      <td>Toyota</td>
      <td>22/03/2015</td>
      <td>750 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
    <tr >
      <td>2</td>
      <td>Crane 8751</td>
      <td>Yamaha</td>
      <td>22/04/2015</td>
      <td>950 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
      <tr >
      <td>3</td>
      <td>Crane</td>
      <td>Toyota</td>
      <td>22/03/2015</td>
      <td>750 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
      <tr >
      <td>4</td>
      <td>Crane</td>
      <td>Toyota</td>
      <td>22/03/2015</td>
      <td>750 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
      <tr >
      <td>5</td>
      <td>Crane</td>
      <td>Toyota</td>
      <td>22/03/2015</td>
      <td>750 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
      <tr >
      <td>6</td>
      <td>Crane</td>
      <td>Toyota</td>
      <td>22/03/2015</td>
      <td>750 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
      <tr >
      <td>7</td>
      <td>Crane</td>
      <td>Toyota</td>
      <td>22/03/2015</td>
      <td>750 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
      <tr >
      <td>8</td>
      <td>Crane</td>
      <td>Toyota</td>
      <td>22/03/2015</td>
      <td>750 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
      <tr >
      <td>9</td>
      <td>Crane</td>
      <td>Toyota</td>
      <td>22/03/2015</td>
      <td>750 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
      <tr >
      <td>10</td>
      <td>Crane</td>
      <td>Toyota</td>
      <td>22/03/2015</td>
      <td>750 000 000</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>N/A</td>
     
    </tr>
   
    <!-- <tr>
      <td>1</td>
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
<a href="/equipment/add"><button id="btn-add-equipment">Add Equipment</button></a>
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
  cursor: pointer;
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
  cursor: pointer;
}
.equipment-block {
  display: grid;
  grid-template-columns: 80% 20%;
  grid-template-rows: 1 1 1;
  background-color: #fafafa;
  border-radius: 3px;
  padding: 0.3rem 1rem;
  /* box-shadow: 3px 3px 5px #bdbdbd;
  margin: 2rem 5rem; */
}
table {
    /* border: 1px solid black; */
    width: 100%;
}
th{
  text-align: left;
  background-color: #CFD8DC;

}
td {
    text-align: left;
    padding-top: 15px;
  
}
tr:nth-child(odd){background-color: white; color: #263238}
tr:nth-child(even){background-color: #ECEFF1; color: #263238}
#th1:curve{
  text-align: left;
  background-color: #B0BEC5;
}
</style>
