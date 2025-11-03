# Security Policy

## Supported Versions

This project is currently in active development. Security updates will be provided for the latest version.

| Version | Supported          |
| ------- | ------------------ |
| latest  | :white_check_mark: |

## Reporting a Vulnerability

We take the security of this project seriously. If you discover a security vulnerability, please follow these steps:

1. **Do Not** disclose the vulnerability publicly until it has been addressed.
2. Email the details to the project maintainer at the contact information available in the repository.
3. Include the following information in your report:
   - Description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact
   - Affected components (Flutter app, Python functions, Node functions, etc.)
   - Suggested fix (if available)

## Response Timeline

- Initial response: Within 48 hours
- Status update: Within 7 days
- Fix timeline: Varies based on severity (critical issues will be prioritized)

## Security Best Practices

### General

- Never commit sensitive data (API keys, passwords, service account keys, etc.) to the repository
- Keep all dependencies up to date
- Review and audit third-party dependencies regularly
- Use environment variables for sensitive configuration
- Enable two-factor authentication on all service accounts

### Flutter Application (`/filch_flutter_app`)

- **Environment Files**: Never commit `.env` files containing API keys or secrets
- **Certificates**: Keep `/certificates/` directory secure and excluded from version control
- **API Keys**: Store Firebase configuration and API keys using environment variables or secure storage
- **Code Obfuscation**: Use code obfuscation for production builds
- **Dependencies**: Regularly run `flutter pub upgrade` and review package updates
- **Secure Storage**: Use `flutter_secure_storage` for sensitive data storage on devices
- **Network Security**: 
  - Always use HTTPS for API calls
  - Implement certificate pinning for production
  - Validate SSL certificates

### Firebase Command Line Scripts (`/firebase_command_line_scripts`)

- **Service Account Keys**: Never commit `serviceAccountKey.json` or similar credential files
- **Dependencies**: Regularly run `npm audit` and fix vulnerabilities
- **Data Files**: Review JSON files in `/data/` for sensitive information before committing
- **Access Control**: Limit Firebase Admin SDK permissions to minimum required scope

### Python Cloud Functions (`/functions`)

- **Environment Variables**: Use environment variables for all sensitive configuration
- **Dependencies**: 
  - Keep `requirements.txt` updated
  - Run `pip-audit` or `safety check` regularly
  - Review dependencies for known vulnerabilities
- **Authentication**: Always validate Firebase Auth tokens in callable functions
- **Firestore Security**: 
  - Validate all user inputs
  - Implement proper authorization checks
  - Never trust client-side data
- **Logging**: Avoid logging sensitive information (tokens, passwords, personal data)

### Node.js Cloud Functions (`/node-functions`)

- **Dependencies**: 
  - Regularly run `npm audit` and fix vulnerabilities
  - Keep `package.json` dependencies updated
  - Review new dependency versions before upgrading
- **TypeScript**: Use strict type checking to catch potential security issues
- **Environment Variables**: Never hardcode secrets in source code
- **Input Validation**: Validate and sanitize all user inputs
- **Error Handling**: Don't expose stack traces or internal error details to clients

### Firebase Security

- **Firestore Rules** (`/firestore.rules`):
  - Implement strict security rules
  - Never use `allow read, write: if true` in production
  - Always validate user authentication and authorization
  - Use field-level validation
  
- **Storage Rules** (`/storage.rules`):
  - Validate file types and sizes
  - Implement authentication checks
  - Use content-type validation
  
- **Firebase Configuration**:
  - Enable App Check for production
  - Use Firebase Security Rules simulator for testing
  - Monitor Security Rules usage in Firebase Console

### API Keys and Secrets (`/keys`)

- **Strict Access Control**: The `/keys/` directory must be excluded from version control
- **Key Rotation**: Rotate API keys and certificates regularly
- **Access Logging**: Monitor and log access to sensitive keys
- **Encryption**: Encrypt keys at rest when stored
- **Distribution**: Use secure channels to share keys with team members

### Development Environment

- **IDE Configuration**: `.idea/`, `.vscode/` directories may contain sensitive paths
- **Build Artifacts**: Ensure build directories don't contain embedded secrets
- **Local Testing**: Use separate Firebase projects for development and production
- **Git Hooks**: Consider implementing pre-commit hooks to scan for secrets

## Known Security Considerations

### Firebase Projects
- Ensure separate Firebase projects for development, staging, and production
- Use Firebase App Check to protect backend resources
- Monitor Firebase usage and set up billing alerts

### Authentication
- Implement proper session management
- Use Firebase Authentication best practices
- Enforce strong password policies
- Implement rate limiting on authentication endpoints

### Data Privacy
- Comply with GDPR, CCPA, and other privacy regulations
- Implement data retention policies
- Provide user data export and deletion capabilities
- Anonymize or pseudonymize sensitive data in logs

## Security Checklist for Contributors

Before submitting a pull request:

- [ ] No hardcoded secrets, API keys, or passwords
- [ ] All sensitive configuration uses environment variables
- [ ] No commits to `/keys/` or credential files
- [ ] Dependencies are up to date (or documented why not)
- [ ] Security rules are tested (Firestore/Storage)
- [ ] Input validation is implemented for all user inputs
- [ ] Error messages don't expose sensitive information
- [ ] Authentication and authorization checks are in place
- [ ] Code follows the principle of least privilege

## Incident Response

In case of a security incident:

1. **Immediate Actions**:
   - Revoke compromised credentials immediately
   - Rotate affected API keys and secrets
   - Block suspicious IP addresses if applicable
   - Document all actions taken

2. **Investigation**:
   - Determine the scope and impact
   - Identify affected users and data
   - Review logs and audit trails

3. **Communication**:
   - Notify affected users if personal data was compromised
   - Update the security advisory
   - Coordinate with the security team

4. **Remediation**:
   - Deploy fixes to production
   - Conduct security testing
   - Update documentation and security practices

## Disclosure Policy

Once a security issue is resolved:

1. Release a patch as soon as possible
2. Publish a security advisory describing the vulnerability
3. Credit the reporter (unless they prefer to remain anonymous)
4. Update this security policy if new practices are needed

## Additional Resources

- [Firebase Security Best Practices](https://firebase.google.com/docs/rules/best-practices)
- [OWASP Mobile Security](https://owasp.org/www-project-mobile-security/)
- [Flutter Security](https://docs.flutter.dev/security)
- [Node.js Security Best Practices](https://nodejs.org/en/docs/guides/security/)
- [Python Security](https://python.readthedocs.io/en/stable/library/security_warnings.html)

---

Thank you for helping keep Filch and its users secure!
