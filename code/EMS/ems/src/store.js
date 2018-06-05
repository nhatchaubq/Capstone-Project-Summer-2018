import Vue from "vue";
import Vuex from "vuex";
import pathify from "vuex-pathify";
import { make } from "vuex-pathify";

Vue.use(Vuex);

const state = {
  isLoggedIn: !!localStorage.getItem("user"),
  title: "",
  showSearchBar: true,
  equipmentPage: {
    isTableMode: true
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
