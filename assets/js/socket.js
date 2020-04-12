import { Socket } from 'phoenix';
let socket = new Socket('/socket', { params: { token: window.userToken } });

socket.connect();

const createSocket = candidateId => {
  let channel = socket.channel(`comments:${candidateId}`, {});
  channel
    .join()
    .receive('ok', resp => {
      console.log(resp);
      renderComments(resp.comments);
    })
    .receive('error', resp => {
      console.log('Unable to join', resp);
    });

  channel.on(`comments:${candidateId}:new`, renderComment);

  document.querySelector('#btn-save-comment').addEventListener('click', () => {
    const text = document.querySelector('#candidate-comment').value;

    channel.push('comment:add', { text: text });
  });
};

function renderComments(comments) {
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment);
  });

  document.querySelector('.comments').innerHTML = renderedComments.join('');
}

function renderComment(event) {
  const renderedComment = commentTemplate(event.comment);

  document.querySelector('.comments').innerHTML += renderedComment;
}

function commentTemplate(comment) {
  let email = 'Anonymous';
  if (comment.user) {
    email = comment.user.email;
  }

  return `
    <article class="message is-info">
      <div class="message-header">
        ${comment.inserted_at}
        <a class="delete"
          data-confirm="Are you sure?" 
          data-csrf="${window.csrfToken}"
          data-method="delete" data-to="/comment/${comment.id}" 
          href="/comment/${comment.id}" rel="nofollow"></a>

      </div>
      <div class="message-body">
        <img class="image is-circle is-64x64 client-logo" src="${comment.user.avatar}">
        <p>${comment.text}</p>
        <blockquote class="is-info">create by: ${comment.user.name}</blockquote>
      </div>
    </article>
  `;
}

window.createSocket = createSocket;