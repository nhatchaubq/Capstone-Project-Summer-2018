import Vue from "vue";
import Vuex from "vuex";
import pathify from "vuex-pathify";
import {
  make
} from "vuex-pathify";

Vue.use(Vuex);

const state = {
  isLoggedIn: !!localStorage.getItem("user"),
  title: "",
  showSearchBar: true,
  notifications: [],
  searchValue: '',
  workOrderPage: {
    searchText: '',
    searchValues: [],
    workingOrderViewMode: true,
  },
  locationPage: {
    isListViewMode: true,
    searchText: '',
    searchValues: [],
  },
  equipmentPage: {
    isTableMode: true,
    searchText: '',
    searchValues: [],
  },
  accountPage: {
    isTableMode: true,
    searchText: '',
    searchValues: [],
  },
  teamPage: {
    detailPage: {
      editMode: false,      
    },
    searchText: '',
    searchValues: [],
  },
  vendorPage: {
    detailPage: {
      editMode: false,
    },
    searchText: '',
    searchValues: [],
  }
};

const mutations = make.mutations(state);
const actions = make.actions(state);

const store = new Vuex.Store({
  plugins: [pathify.plugin],
  state,
  mutations,
  actions
});

export default store;