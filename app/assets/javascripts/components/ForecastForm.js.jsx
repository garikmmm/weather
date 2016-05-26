var ForecastForm = React.createClass({
    getInitialState: function() {
        return {location_id: '', geolocation_method: 1};
    },
    handleLocationChange: function(location_id) {
        this.setState({location_id: location_id});
    },
    handleGeolocationChange: function(e) {
        this.setState({geolocation_method: e.target.value});
    },
    handleSubmit: function(e) {
        e.preventDefault();
        var location_id = this.state.location_id;
        var geolocation_method = this.state.geolocation_method;
        if (!location_id || !geolocation_method) {
            alert("Please select values in the form");
            return false;
        }
        this.props.onForecastSubmit({location_id: location_id, geolocation_method: geolocation_method});
    },
    render: function() {
        return (
            <form onSubmit={this.handleSubmit}>
                <label for="react-location">Location:</label>
                <Autocomplete onLocationChange={this.handleLocationChange} />
                <label for="react-location">Geolocation method:</label>
                <select id="react-geolocation" onChange={this.handleGeolocationChange} value="{this.state.geolocation_method}">
                    <option value="1">Database</option>
                    <option value="2">Google Maps</option>
                </select>
                <br/>
                <input type="submit" value="Show results" />
            </form>
        );
    }
});
