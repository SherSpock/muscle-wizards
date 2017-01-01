var DataTable = {
  selector: null,

  init: function(selector) {
    this.selector = selector;
    this.showRecentDataRows();
    this.enableListToggleLink();
  },

  showRecentDataRows: function() {
    this.getHiddenRows().each(function(i, hiddenRow) {
      if (i < 14) {
        $(hiddenRow).removeClass('hide');
      }
    });
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
        if (i >= 14) {
          $(row).addClass('hide');
        }
      });
    }
  }
};
