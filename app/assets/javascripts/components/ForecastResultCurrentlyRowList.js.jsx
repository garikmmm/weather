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
