var Autocomplete = React.createClass({
    handleLocationChange: function(e) {
        this.props.onLocationChange(e.target.value);
    },
    componentDidMount: function() {
        $(this.refs['locationSelect']).selectize({
            valueField: 'id',
            labelField: 'name',
            searchField: 'name',
            create: true,
            load: function(query, callback) {
                if (!query.length) {
                    return callback();
                }
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
        }).on("change", this.handleLocationChange);
    },
    componentWillUnmount: function() {
        $(this.refs['locationSelect']).selectize()[0].selectize.destroy();
    },
    shouldComponentUpdate: function(props) {
        return false;
    },
    render: function() {
        return (
            <select id="react-location" ref="locationSelect"></select>
        );
    }
});
