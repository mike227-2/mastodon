import { connect } from 'react-redux';
import TextIconButton from '../components/text_icon_button';
import { changeComposeCostness } from '../../../actions/compose';
import { injectIntl, defineMessages } from 'react-intl';

const messages = defineMessages({
  marked: { id: 'compose_form.spoiler.marked', defaultMessage: 'Text is hidden behind warning' },
  unmarked: { id: 'compose_form.spoiler.unmarked', defaultMessage: 'Text is not hidden' },
  // marked: { id: 'compose_form.cost.marked', defaultMessage: 'Text is hidden behind warning' },
  // unmarked: { id: 'compose_form.cost.unmarked', defaultMessage: 'Text is not hidden' },
});

const mapStateToProps = (state, { intl }) => ({
  label: '$',
  title: intl.formatMessage(state.getIn(['compose', 'cost']) ? messages.marked : messages.unmarked),
  active: state.getIn(['compose', 'cost']),
  ariaControls: 'cw-cost-input',
});

const mapDispatchToProps = dispatch => ({

  onClick () {
    console.log("clicked");
    dispatch(changeComposeCostness());
  },

});

export default injectIntl(connect(mapStateToProps, mapDispatchToProps)(TextIconButton));
