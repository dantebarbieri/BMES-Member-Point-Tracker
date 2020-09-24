Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'qJJz8ozFds443Sdntj79b6z6EnWK6qPf',
    'ByOVYnikyEe0CUmV_V8kPyb43XI-lZ2cGeZ5nn-O_FFTijceiWhozRgEUZOAlNoL',
    'bmes-member-tracker.us.auth0.com',
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid email profile'
    }
  )
end