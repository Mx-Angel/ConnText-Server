import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';
import prettierRecommended from 'eslint-config-prettier';

export default tseslint.config(
  {
    ignores: ['dist/', 'node_modules/', 'coverage/'],
  },
  eslint.configs.recommended,
  ...tseslint.configs.recommendedTypeChecked,
  prettierRecommended,
  {
    languageOptions: {
      parserOptions: {
        projectService: true,
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
  {
    files: ['**/*.ts'],
    rules: {
      '@typescript-eslint/no-array-delete': 'error',
      '@typescript-eslint/consistent-type-assertions': 'warn',
      '@typescript-eslint/no-confusing-non-null-assertion': 'warn',
      '@typescript-eslint/explicit-function-return-type': 'warn',

      // Severity overrides from recommendedTypeChecked
      '@typescript-eslint/no-explicit-any': 'warn',
      '@typescript-eslint/no-unsafe-argument': 'warn',
      '@typescript-eslint/no-unsafe-member-access': 'warn',
      '@typescript-eslint/no-unsafe-return': 'warn',
      '@typescript-eslint/no-unsafe-assignment': 'warn',
      '@typescript-eslint/no-unnecessary-type-assertion': 'warn',
      '@typescript-eslint/no-extra-non-null-assertion': 'warn',
      '@typescript-eslint/no-empty-object-type': 'warn',
      '@typescript-eslint/prefer-as-const': 'warn',
    },
  },
);
