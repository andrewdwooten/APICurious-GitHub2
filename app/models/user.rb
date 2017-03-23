class User < ApplicationRecord

    def self.from_github(data, access_token)
      user           = User.find_or_create_by(uid: data["id"], provider: 'github')
      user.update_attributes(name:  data['login'],
                             token: access_token,
                             email: data['email'],
                             image: data['avatar_url'])
      user
    end

    def followers
      Follow.followers(self.name)
    end

    def following
      Follow.following(self.name)
    end

    def starred_count
      Repository.count_of_starred(self.name)
    end

    def recent_commits
      Commit.recent(self.name)
    end

    def repositories_by_name
      Repository.repositories_by_name(self.name)
    end

    def organizations
      Organization.organizations(self.name)
    end

    def follow_activity
      FollowActivity.following_activity(self.name)
    end

    def create_repo(repo_name)
      Repository.create(self.token, repo_name)
    end

    def open_pull_requests
      PullRequest.pull_requests(self.name)
    end

end
