<template>
  <div id="app">
    <p>{{ token }}</p>
  </div>
</template>

<script>
export default {
  props: [ 'token', 'endpoint' ],
  mounted () {
    this.pollSmartthings()
  },
  data: function () {
    return {
      loading: false,
      pollInterval: undefined
    }
  },
  methods: {
    async pollSmartthings (token, endpoint) {
      this.pollInterval = setInterval(async function () {
        console.log('sup')
      }.bind(this), 6000)
    }
  }
}
</script>

<style>

</style>
