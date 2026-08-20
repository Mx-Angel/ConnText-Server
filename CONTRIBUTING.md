# Contributing to ConnText-Server

## Getting Started

1. Fork the repository
2. Clone your fork
3. Install dependencies: `npm install`
4. Create a feature branch: `git checkout -b feature/your-feature`

## Coding Conventions

### Naming

| Element          | Convention  | Example                            |
| ---------------- | ----------- | ---------------------------------- |
| Variables        | camelCase   | `userId`, `channelName`            |
| Functions        | camelCase   | `getMessages`, `validateToken`     |
| Classes          | PascalCase  | `MessageService`, `AuthController` |
| Types/Interfaces | PascalCase  | `UserProfile`, `TokenPair`         |
| Constants        | UPPER_SNAKE | `MAX_RETRIES`, `JWT_SECRET`        |
| Files            | kebab-case  | `auth.ts`, `messaging.ts`          |
| Database columns | snake_case  | `user_id`, `created_at`            |

### File Structure

Files follow the pattern `<layer>/<name>.ts`:

- `routes/auth.ts`: route definitions
- `controllers/auth.ts`: HTTP request/response handling
- `services/auth.ts`: business logic
- `models/user.ts`: database interaction

### Formatting and Linting

This project uses **ESLint** for code quality and **Prettier** for formatting.

- Run the linter: `npm run lint`
- Fix auto-fixable issues: `npm run lint:fix`
- Format code: `npm run format`

Configure your editor to format on save with Prettier for the best experience, for example, in VSCode, install the Prettier extension and add the following to your `settings.json`:

```json
"editor.formatOnSave": true,
"editor.defaultFormatter": "esbenp.prettier-vscode"
```

### TypeScript

- Avoid `any`, instead use proper types or `unknown` if the type is genuinely uncertain
- Always handle errors explicitly, don't leave empty `catch` blocks
- Use `const` by default, `let` only when reassignment is needed, never `var`
- Prefer `async/await` over raw Promises

### Git

- All commits must be signed (`git commit -s`)
- All commits must be verified
- Link PRs to their corresponding issue
- Keep commits focused: one logical change per commit

#### Branch Naming Conventions

We will follow v1.1.0 of the standard defined by [Conventional Branch](https://conventionalbranch.org/):

- `feature/` (or `feat/`): For new features (e.g., `feature/add-login-page`, `feat/add-login-page`)
- `bugfix/` (or `fix/`): For bug fixes (e.g., `bugfix/fix-header-bug`, `fix/header-bug`)
- `hotfix/`: For urgent fixes (e.g., `hotfix/security-patch`)
- `release/`: For branches preparing a release (e.g., `release/v1.2.0`)
- `chore/`: For non-code tasks like dependency, docs updates (e.g., `chore/update-dependencies`)

### API Conventions

- Endpoints follow the patterns defined in the [OpenAPI spec](https://github.com/Mx-Angel/ConnText-Docs/tree/main/Design/API)
- All responses use the shared `Error` schema for error cases
- Use appropriate HTTP status codes as documented in the spec
- Request/response bodies use `snake_case` for property names

## Reporting Issues

Use GitHub Issues. Include steps to reproduce, expected behaviour, and actual behaviour.
