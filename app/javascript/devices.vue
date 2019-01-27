<template>
<div class="table-responsive">
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
      <% @devices.each do |device| %>
        <%= content_tag :tr, id: dom_id(device), class: dom_class(device) do %>
          <td>
            <!-- Being lazy and using bootstrap classes here for color -->
            <% case device.hardware_type %>
            <% when "st_switch" %>
              <% if device.status == 'on' %>
                <%= icon('fas', 'lightbulb', class: 'text-warning') %>
              <% else %>
                <%= icon('fas', 'lightbulb', class: 'text-muted') %>
              <% end %>
            <% when "st_lock" %>
              <% if device.status == 'locked' %>
                <%= icon('fas', 'lock', class: 'text-success') %>
              <% else %>
                <%= icon('fas', 'lock-open', class: 'text-danger') %>
              <% end %>
            <% when "st_thermostat" %>
              <% if device.status == 'cooling' %>
                <%= icon('fas', 'temperature-high', class: 'text-primary') %>
              <% elsif device.status == 'heating' %>
                <%= icon('fas', 'temperature-high', class: 'text-danger') %>
              <% else %>
                <%= icon('fas', 'temperature-high', class: 'text-muted') %>
              <% end %>
            <% end %>
          </td>
          <td><%= device.display_name %></td>
          <td><%= device.status %></td>
          <td>
            <% if device.hardware_type == "st_thermostat" %>
              Mode: <%= device.meta["mode"] %> | 
              Temperature: <%= device.meta["temperature"] %> °F
            <% end %>
          </td>
        <% end %>
      <% end %>
    </tbody>
  </table>
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
      pollInterval: undefined,
      devices: []
    }
  },
  methods: {
    async pollSmartthings (token, endpoint) {
      this.pollInterval = setInterval(async function () {
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
        }
      }.bind(this), 6000)
    }
  }
}
</script>

<style>

</style>
