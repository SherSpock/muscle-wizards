var DataTable = {
  selector: null,

  init: function(selector) {
    this.selector = selector;
    this.showRecentDataRows();
    this.enableListToggleLink();
  },

  showRecentDataRows: function() {
    this.getHiddenRows().each(function(i, row) {
      if (i < 14) {
        $(row).removeClass('hide');
      }
      if (i === 13) {
        debugger;
        this.styleLastVisibleRow(row);
      }
    }.bind(this));
  },

  getHiddenRows: function() {
    var selectorString = this.selector + ' tr.hide';
    return $(selectorString);
  },

  enableListToggleLink: function() {
    if (this.getHiddenRows().length > 14) {
      this.showListToggleLink();
      this.addListToggleEventHandler();
    }
  },

  showListToggleLink: function() {
    $(this.selector + ' .list-toggle').removeClass('hide');
  },

  addListToggleEventHandler: function() {
    $(this.selector + ' .list-toggle').on('click', function(event) {
      event.preventDefault();
      this.toggleRows();
      this.toggleButtonText(event.target);
    }.bind(this));
  },

  toggleButtonText: function(button) {
    if (this.getHiddenRows().length) {
      $(button).text('Last 14 entries - click to see all data');
    } else {
      $(button).text('Showing all entries - click to see less');
    }
  },

  toggleRows: function() {
    var rows = this.getHiddenRows();
    if (rows.length) {
      rows.each(function(i, row) {
        $(row).removeClass('hide');
      });
    } else {
      $('tr').each(function(i, row) {
        if (i >= 14) $(row).addClass('hide');
        if (i === 13) this.styleLastVisibleRow(row);
      }.bind(this));
    }
  },

  styleLastVisibleRow: function(row) {
    var dataCells = $(row).find('td');
    dataCells.each(function(i, dataCell) {
      $(dataCell).css('border-bottom', 'none');
      if (i === 0) $(dataCell).css('border-bottom-left-radius', '2px');
      if (i === dataCells.length - 1) $(dataCell).css('border-bottom-right-radius', '2px');
    });
  }
};
