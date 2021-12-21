# How to cut a CAPI release
1. Make sure we're ready to release:
  - Are there any outstanding bugs or issues that need to be pulled in before we can release?
  - Are all the blobstore fanout tests green?
2. Ship it in CI:
  - Log in to [CAPI CI](https://ci.cake.capi.land/teams/main/pipelines/capi?group=ship-it)
  - Unpause & run the `ship-it` job (in the `ship-it` group)
  - Wait for the pipeline to complete.
  - Pause the `ship-it` job.
3. Create the release notes
Currently, we have to manually create the release notes.

  - Make sure your local copy of the repo is up to date: `cd` into `capi-release` and `git pull`
  - Run `git log 1.xxx.0...1.yyy.0` to get the list of commits since the last release (replace 1.xxx.0 with the last release number, and 1.yyy.0 with the newly generated release number).
      - The full commit message of a ‘Bump …’ commit should contain the relevant commit message and PR/Issue number for the release notes.
  - Clean up the release notes (e.g. remove duplicate messages, reword PR info if needed).
4. Fill out the release and publish it
  - The `ship-it` pipeline should have created a draft Github release.
  - Paste in the release notes into the relevant sections in the release draft.
  - Add any Highlights to the top of the release notes.
  - Publish the release.
5. Follow up
  - Tell folks you shipped it.
      - Announce in #capi
      - Any specific teams/people who were waiting on the release
  - Close any open Github issues that were resolved by the release.
  - If there were any changes to the V2 docs, push the V2 docs app via [CI](https://ci.cake.capi.land/teams/main/pipelines/capi/jobs/update-and-push-docs-v2)