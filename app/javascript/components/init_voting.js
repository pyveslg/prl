const initVoting = () => {
  const votesDiv = document.querySelectorAll('.votes');
  votesDiv.forEach((votes) => {
    votes.addEventListener('click', (event) => {
      const self = event.target
      console.log(self)
      const commitId = self.dataset.commit_id;
      const voteValue = self.dataset.value;
      const voting = self.dataset.vote;
      // const self = event.currentTarget
      // voteValue === '1' ? event.currentTarget.parentElement.querySelector('.red').classList.remove('red') : event.currentTarget.parentElement.querySelector('.green').classList.remove('green')
        // voteValue === '1' ? vote.classList.toggle('red') : vote.classList.toggle('green')
      // self.classList.add(voteValue === '1' ? 'green' : 'red')
      console.log(window.location.origin + '/vote' + `?commit_id=${commitId}&value=${voteValue}&vote=${voting}`)
      fetch(window.location.origin + '/vote' + `?commit_id=${commitId}&value=${voteValue}&vote=${voting}`)
        .then(response => response.json())
        .then((data) => {
          console.log(data);
          const voteCount = document.querySelector(`#commit-${commitId}`)
          voteCount.innerText = data.votes
          self.parentNode.innerHTML = data.content
        })
      })
  })
}

export { initVoting };
