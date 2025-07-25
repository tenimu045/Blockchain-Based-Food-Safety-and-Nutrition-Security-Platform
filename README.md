# Blockchain-Based Food Safety and Nutrition Security Platform

A comprehensive smart contract system built on Stacks blockchain to ensure food safety, verify nutritional content, optimize food distribution, manage school nutrition programs, and strengthen local food systems.

## Overview

This platform consists of five interconnected smart contracts that work together to create a transparent, secure, and efficient food safety and nutrition ecosystem:

1. **Foodborne Illness Tracking Contract** - Identifies contamination sources and prevents widespread food poisoning
2. **Nutritional Content Verification Contract** - Validates accuracy of food labeling and nutritional information
3. **Food Bank Distribution Optimization Contract** - Efficiently distributes donated food to food-insecure populations
4. **School Nutrition Program Contract** - Ensures students receive healthy meals that meet nutritional standards
5. **Local Food System Strengthening Contract** - Supports local farmers and reduces food transportation emissions

## Key Features

### Food Safety & Tracking
- Real-time contamination source identification
- Automated recall systems
- Supply chain transparency
- Incident reporting and response

### Nutritional Verification
- Blockchain-verified nutritional labels
- Third-party verification system
- Consumer trust through transparency
- Regulatory compliance tracking

### Distribution Optimization
- Smart matching of donations to needs
- Inventory management for food banks
- Expiration date tracking
- Geographic distribution optimization

### School Nutrition
- Meal planning and approval workflows
- Nutritional standard compliance
- Student dietary requirement tracking
- Budget management and reporting

### Local Food Systems
- Farmer registration and verification
- Local sourcing incentives
- Carbon footprint tracking
- Community-supported agriculture (CSA) management

## Smart Contract Architecture

Each contract is designed to be independent while sharing common data structures and validation patterns. The contracts use native Clarity syntax and follow best practices for security and efficiency.

### Data Types Used
- \`uint\` for quantities, ratings, and timestamps
- \`principal\` for user and organization identification
- \`(string-ascii 100)\` for names and descriptions
- \`(string-ascii 500)\` for detailed information
- \`bool\` for status flags and approvals

### Error Handling
All contracts implement comprehensive error handling with descriptive error codes:
- Input validation errors (ERR-INVALID-INPUT)
- Authorization errors (ERR-UNAUTHORIZED)
- Not found errors (ERR-NOT-FOUND)
- Already exists errors (ERR-ALREADY-EXISTS)

## Getting Started

### Prerequisites
- Clarinet CLI installed
- Node.js and npm for testing
- Stacks wallet for deployment

### Installation

1. Clone the repository
2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

4. Deploy contracts:
   \`\`\`bash
   clarinet deploy
   \`\`\`

## Testing

The platform includes comprehensive test suites using Vitest for each contract. Tests cover:
- Contract deployment and initialization
- Function parameter validation
- Authorization and access control
- Data integrity and state management
- Error handling and edge cases

Run tests with:
\`\`\`bash
npm test
\`\`\`

## Usage Examples

### Reporting a Foodborne Illness
\`\`\`clarity
(contract-call? .foodborne-illness-tracking report-illness
"Salmonella outbreak"
"Local restaurant chain"
u5)
\`\`\`

### Verifying Nutritional Content
\`\`\`clarity
(contract-call? .nutritional-content-verification submit-for-verification
"Organic Cereal Brand"
u250 u5 u30 u10)
\`\`\`

### Donating to Food Bank
\`\`\`clarity
(contract-call? .food-bank-distribution donate-food
"Canned vegetables"
u100
u1735689600)
\`\`\`

## Security Considerations

- All contracts implement proper access control
- Input validation prevents malicious data entry
- State changes are atomic and reversible where appropriate
- No cross-contract dependencies to minimize attack surface

## Contributing

1. Fork the repository
2. Create a feature branch
3. Write tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

MIT License - see LICENSE file for details

## Support

For questions and support, please open an issue in the repository or contact the development team.
