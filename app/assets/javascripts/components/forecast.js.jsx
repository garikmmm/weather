var ForecastForm = React.createClass({
    handleSubmit: function(e) {
        e.preventDefault();
        var location_id = $("#react-location", ReactDOM.findDOMNode(this)).val();
        var geolocation_method = $("#react-geolocation", ReactDOM.findDOMNode(this)).val();
        if (!location_id || !geolocation_method) {
            return false;
        }
        this.props.onForecastSubmit({location_id: location_id, geolocation_method: geolocation_method});
        // this.setState({author: '', text: ''});
    },
    componentDidMount: function() {
        $("#react-location", ReactDOM.findDOMNode(this)).selectize({
            valueField: 'id',
            labelField: 'name',
            searchField: 'name',
            create: true,
            load: function(query, callback) {
                if (!query.length) return callback();
                $.ajax({
                    url: "/search_location/" + encodeURIComponent(query),
                    type: 'GET',
                    error: function() {
                        callback();
                    },
                    success: function(res) {
                        callback(res);
                    }
                });
            }
        });
    },

    componentWillUnmount: function() {
        alert('Not implemented - componentWillUnmount');
        return;
        $(ReactDOM.findDOMNode(this)).selectize('destroy');
    },
    render: function() {
        return (
            <form onSubmit={this.handleSubmit}>
                <select id="react-location"></select>
                <select id="react-geolocation">
                    <option value="1">Database</option>
                    <option value="2">Google Maps</option>
                </select>
                <input type="submit" value="Post" />
            </form>
        );
    }
});

var ForecastResultCurrentlyRow = React.createClass({
    render: function() {
        return (
            <li class="list-group-item"><span class="badge">{this.props.rowValue}</span>{this.props.rowName}</li>
        );
    }
});
var ForecastResultCurrentlyRowList = React.createClass({
    getInitialState: function() {
        return {data: {}};
    },
    render: function() {
        if ($.isEmptyObject(this.props.data)) {
            return (
                <div></div>
            );
        }
        if (!this.props.data.status) {
            return (
                <div>Error</div>
            );
        }
        if (!this.props.data.data.currently) {
            return (
                <div>Result is empty</div>
            );
        }
        var currently = this.props.data.data.currently;
        return (
            <ul class="list-group">
                <ForecastResultCurrentlyRow rowName="Summary" rowValue={currently.summary}></ForecastResultCurrentlyRow>
                <ForecastResultCurrentlyRow rowName="WindSpeed" rowValue={currently.windSpeed}></ForecastResultCurrentlyRow>
                <ForecastResultCurrentlyRow rowName="Pressure" rowValue={currently.pressure}></ForecastResultCurrentlyRow>
                <ForecastResultCurrentlyRow rowName="Humidity" rowValue={currently.humidity}></ForecastResultCurrentlyRow>
            </ul>
        );
    }
});

var ForecastPage = React.createClass({
    getInitialState: function() {
        return {data: {}};
    },
    formSubmitHandler: function(formData) {
        $.ajax({
            url: "/forecast",
            dataType: 'json',
            type: 'GET',
            data: formData,
            success: function(data) {
                this.setState({data: data});
            }.bind(this),
            error: function(xhr, status, err) {
                this.setState({data: {}});
                alert("error occured");
            }.bind(this)
        });
    },
    render: function() {
        return (
            <div>
                <ForecastForm onForecastSubmit={this.formSubmitHandler}></ForecastForm>
                <ForecastResultCurrentlyRowList data={this.state.data}></ForecastResultCurrentlyRowList>
            </div>
        );
    }
});

