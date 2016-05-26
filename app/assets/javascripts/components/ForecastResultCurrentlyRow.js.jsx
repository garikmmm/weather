var ForecastResultCurrentlyRow = React.createClass({
    render: function() {
        return (
            <li className="list-group-item"><span className="badge">{this.props.rowValue}</span>{this.props.rowName}</li>
        );
    }
});
