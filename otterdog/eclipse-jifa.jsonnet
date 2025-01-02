local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('technology.jifa', 'eclipse-jifa') {
  settings+: {
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('jifa') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "javascript",
        "javascript-typescript",
        "typescript"
      ],
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "🔬 Online Heap Dump, GC Log, Thread Dump & JFR File Analyzer.",
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-jifa.github.io/jifa",
      topics+: [
        "gc-log",
        "heap-dump",
        "java",
        "jfr",
        "jvm",
        "k8s",
        "online-analyzer",
        "thread-dump",
        "troubleshooting"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://oapi.dingtalk.com/robot/send?access_token=ffc24f077919df275c7250e56a3a32b93e6a906a69665a29f1f8b4ba45e5498e') {
          content_type: "json",
          events+: [
            "create",
            "issues",
            "pull_request_review",
            "release"
          ],
        },
      ],
      secrets: [
        orgs.newRepoSecret('DOCKER_PASSWORD') {
          value: "pass:bots/technology.jifa/docker.com/api-token",
        },
        orgs.newRepoSecret('DOCKER_USERNAME') {
          value: "pass:bots/technology.jifa/docker.com/username",
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          dismisses_stale_reviews: true,
          is_admin_enforced: true,
          required_approving_review_count: 1,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
  ],
}
