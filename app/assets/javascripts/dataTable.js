var DataTable = {

  init: function(selector, rowsToShow) {
    var rowsToShow = rowsToShow || 14;
    this.showRecentDataRows(selector, rowsToShow);
    this.enableListToggleLink(selector, rowsToShow);
  },

  showRecentDataRows: function(selector, rowsToShow) {
    this.getHiddenRows(selector).each(function(i, row) {
      if (i < rowsToShow) {
        $(row).removeClass('hide');
      }
      if (i === rowsToShow - 1) {
        this.styleLastVisibleRow(row);
      }
    }.bind(this));
  },

  getHiddenRows: function(selector) {
    var selectorString = selector + ' tr.hide';
    return $(selectorString);
  },

  enableListToggleLink: function(selector, rowsToShow) {
    if (this.getHiddenRows(selector).length > rowsToShow) {
      this.showListToggleLink(selector);
      this.addListToggleEventHandler(selector, rowsToShow);
    }
  },

  showListToggleLink: function(selector) {
    $(selector + ' .list-toggle').removeClass('hide');
  },

  addListToggleEventHandler: function(selector, rowsToShow) {
    $(selector + ' .list-toggle').on('click', function(event) {
      event.preventDefault();
      this.toggleRows(selector, rowsToShow);
      this.toggleButtonText(event.target, selector, rowsToShow);
    }.bind(this));
  },

  toggleButtonText: function(button, selector, rowsToShow) {
    if (this.getHiddenRows(selector).length) {
      $(button).text('Last ' + rowsToShow + ' entries - click to see all data');
    } else {
      $(button).text('Showing all entries - click to see less');
    }
  },

  toggleRows: function(selector, rowsToShow) {
    var rows = this.getHiddenRows(selector);
    if (rows.length) {
      rows.each(function(i, row) {
        $(row).removeClass('hide');
      });
    } else {
      $(selector + ' tr').each(function(i, row) {
        if (i >= rowsToShow) $(row).addClass('hide');
        if (i === rowsToShow - 1) this.styleLastVisibleRow(row);
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
