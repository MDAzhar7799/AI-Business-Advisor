# AI Business Growth Advisor - Setup Guide

## Project Overview
This is an AI-powered business intelligence system that helps users:
- Choose safe business locations
- Predict future growth
- Analyze flood/earthquake risks
- Suggest suitable business types
- Find international demand
- Connect with dealers/importers
- Optimize export routes

## Prerequisites
- Python 3.8+
- Node.js 16+
- npm or yarn

## Quick Start

### 1. Backend Setup
```bash
# Navigate to backend directory
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On Mac/Linux:
source venv/bin/activate

# Install dependencies
pip install -r ../requirements.txt

# Start Flask server
python app.py
```

The backend will run on `http://localhost:5000`

### 2. Frontend Setup
```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Start development server
npm start
```

The frontend will run on `http://localhost:3000`

### 3. Train ML Models (Optional)
```bash
# Navigate to project root
cd ..

# Train flood prediction model
python ml_models/flood_prediction.py

# This will create model files in ml_models/ directory
```

## Environment Configuration

### Backend Environment Variables
Create a `.env` file in the backend directory:

```env
# Flask Configuration
FLASK_ENV=development
SECRET_KEY=your-secret-key-here
JWT_SECRET_KEY=your-jwt-secret-key-here

# Firebase Configuration (optional)
FIREBASE_PROJECT_ID=your-firebase-project-id
FIREBASE_PRIVATE_KEY_ID=your-private-key-id
FIREBASE_PRIVATE_KEY=your-private-key
FIREBASE_CLIENT_EMAIL=your-client-email
FIREBASE_CLIENT_ID=your-client-id

# API Keys (optional for enhanced features)
GOOGLE_MAPS_API_KEY=your-google-maps-api-key
OPENWEATHER_API_KEY=your-openweather-api-key
USGS_API_KEY=your-usgs-api-key
UN_COMTRADE_API_KEY=your-un-comtrade-api-key
```

### Frontend Environment Variables
Create a `.env` file in the frontend directory:

```env
REACT_APP_API_URL=http://localhost:5000
```

## Firebase Setup (Optional but Recommended)

1. Create a Firebase project at https://console.firebase.google.com
2. Enable Authentication and Firestore Database
3. Download service account key as `firebase-credentials.json`
4. Place it in the backend directory

## Features Implemented

### ✅ Completed Features
- **User Authentication**: Login/Register system with JWT tokens
- **Dashboard**: Overview with key metrics and insights
- **Risk Analysis**: Flood and earthquake risk assessment
- **Business Recommendations**: AI-powered business suggestions
- **International Markets**: Demand forecasting for export markets
- **Flood Prediction ML Model**: Random Forest-based risk assessment

### 🚧 In Progress
- Earthquake risk prediction model
- Advanced business recommendation algorithms
- Real-time API integrations
- Firebase database integration

### 📋 Planned Features
- Interactive maps with risk visualization
- Chart.js integration for data visualization
- AI chatbot for business guidance
- Dealer/importer connection system
- Export route optimization

## API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login

### Risk Analysis
- `POST /api/risk/flood` - Flood risk analysis
- `POST /api/risk/earthquake` - Earthquake risk analysis

### Business Intelligence
- `POST /api/business/recommend` - Business recommendations
- `POST /api/business/predict-growth` - Growth prediction
- `POST /api/international/demand` - International demand analysis

### Dashboard
- `GET /api/dashboard/overview` - Dashboard overview data

## Testing the Application

1. Start both backend and frontend servers
2. Open `http://localhost:3000` in your browser
3. Register a new account
4. Explore the dashboard and features

## Development Notes

### Backend (Flask)
- Built with Flask and Flask-JWT-Extended for authentication
- Scikit-learn for ML models
- CORS enabled for frontend communication
- Modular structure with separate API routes

### Frontend (React)
- React 18 with TypeScript
- Tailwind CSS for styling
- React Router for navigation
- Axios for API communication
- Context API for state management

### ML Models
- Flood prediction using Random Forest
- Synthetic training data for demonstration
- Feature importance tracking
- Scalable to real data integration

## Deployment

### Backend Deployment Options
- **Render**: Easy deployment for Flask apps
- **Heroku**: Classic Python deployment
- **AWS Elastic Beanstalk**: Scalable option
- **DigitalOcean**: Affordable cloud hosting

### Frontend Deployment Options
- **Vercel**: Excellent for React apps
- **Netlify**: Simple static hosting
- **AWS S3 + CloudFront**: Scalable option

## Troubleshooting

### Common Issues

1. **CORS Errors**: Ensure backend CORS is properly configured
2. **Module Not Found**: Run `pip install -r requirements.txt`
3. **Frontend Build Errors**: Run `npm install` and check Node.js version
4. **Database Connection**: Firebase setup is optional for basic functionality

### Port Conflicts
- Default ports: Backend (5000), Frontend (3000)
- Change ports if needed in respective configuration files

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is open source and available under the MIT License.

## Support

For issues and questions:
1. Check the troubleshooting section
2. Review the API documentation
3. Create an issue in the repository

---

**Note**: This is a comprehensive MVP with room for enhancement. The current implementation uses mock data for demonstration but is structured to easily integrate with real APIs and databases.
