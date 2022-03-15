import React from 'react';

export default function UnlockComponent(props) {
  const status = props.status;

  return (<div>
	<p>
	Post is locked. Contains {status.get('media_attachments_count')}{status.get('sensitive') ? " sensitive":''} media.
	</p>
	<a href={"/buy/" + status.get('id')}>
	Unlock for $ {status.get('cost')/100}
	</a>
	</div>);

}
