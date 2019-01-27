<template>
<div v-if="loading" class="d-flex align-items-center border p-2">
  <strong>Loading...</strong>
  <div class="spinner-border ml-auto" role="status" aria-hidden="true"></div>
</div>
<div v-else class="table-responsive">
  <table class="table table-striped table-bordered table-hover">
    <thead>
      <tr>
        <th></th>
        <th>Device Name</th>
        <th>Status</th>
        <th></th>
      </tr>
    </thead>

    <tbody>
      <tr v-for="device in devices">
        <td>
          <span v-html="deviceIcon(device)"></span>
        </td>
        <td>
          {{ device['name'] }}
        </td>
        <td>
          {{ device['value'] }}
        </td>
        <td>
          <span v-if="device['type'] == 'st_thermostat'">
            Mode: {{ device.meta['mode'] }} | 
            Temperature: {{ device.meta['temperature'] }} °F
          </span>
        </td>
      </tr>
    </tbody>
  </table>
</div>
</template>

<script>
export default {
  props: [ 'token', 'endpoint' ],
  mounted () {
    this.pollSmartthings()
    this.pollInterval = setInterval(this.pollSmartthings, 6000)
  },
  data: function () {
    return {
      loading: true,
      pollInterval: undefined,
      devices: []
    }
  },
  methods: {
    deviceIcon (device) {
      switch(device['type']){
        case 'st_switch':
          return device['value'] == 'on' ? 
            `<i class="fas fa-lightbulb text-warning"></i>` :
            `<i class="fas fa-lightbulb text-muted"></i>`
        case 'st_lock':
          return device['value'] == 'locked' ? 
            `<i class="fas fa-lock text-success"></i>` :
            `<i class="fas fa-lock-open text-danger"></i>`
        case 'st_thermostat':
          switch(device['value']){
            case 'cooling':
              return `<i class="fas fa-temperature-high text-primary"></i>`
            case 'heating':
              return `<i class="fas fa-temperature-high text-danger"></i>`
            default:
              return `<i class="fas fa-temperature-high text-muted"></i>`
          }
      }
    },
    async pollSmartthings () {
      try {
        let result = await $.ajax({
          type: 'GET',
          url: `${this.endpoint}/devicesJSONP`,
          dataType: 'jsonp',
          headers: {
            Authorization: `Bearer ${this.token}`
          }
        })

        this.devices = result
      } catch(err) {
        console.error(err)
      } finally {
        this.loading = false
      }
    }
  }
}
</script>

<style>

</style>
