const initVoting = () => {
  const votesDiv = document.querySelectorAll('.votes');
  votesDiv.forEach((votes) => {
    votes.addEventListener('click', (event) => {
      const self = event.target
      const commitId = self.dataset.commit_id;
      const voteValue = self.dataset.value;
      const voting = self.dataset.vote;
      fetch(`/vote?commit_id=${commitId}&value=${voteValue}&vote=${voting}`)
        .then(response => response.json())
        .then((data) => {
          const voteCount = document.querySelector(`#commit-${commitId}`)
          voteCount.innerText = data.votes
          self.parentNode.innerHTML = data.content
        })
      })
  })
}

export { initVoting };
