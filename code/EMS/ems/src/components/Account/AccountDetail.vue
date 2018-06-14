<template>
    <div>
    <image-modal :visible="true" transition="roll">
      <p class="image is-4by3">
        <img src="http://placehold.it/1280x960">
      </p>
    </image-modal>

    <card-modal :visible="true" :title="title" transition="zoom">
    <modal-card-title>Hello kira! </modal-card-title>
      <div class="content has-text-centered">
      </div>
      <div>Hello world!!</div>
    </card-modal>
  </div>
</template>

<script>
import { Modal, ImageModal, CardModal } from "vue-bulma-modal";

export default {
  components: {
    Modal,
    ImageModal,
    CardModal
  }
};
</script>

<style>
</style>
