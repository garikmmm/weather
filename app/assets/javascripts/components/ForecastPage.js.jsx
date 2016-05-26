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
