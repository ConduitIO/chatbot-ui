INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user) VALUES
('00000000-0000-0000-0000-000000000000', 'e9fc7e46-a8a5-4fd4-8ba7-af485013e6fa', 'authenticated', 'authenticated', 'test@test.com', crypt('password', gen_salt('bf')), '2023-02-18 23:31:13.017218+00', NULL, '', '2023-02-18 23:31:12.757017+00', '', NULL, '', '', NULL, '2023-02-18 23:31:13.01781+00', '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2023-02-18 23:31:12.752281+00', '2023-02-18 23:31:13.019418+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, 'f');

UPDATE public.profiles SET has_onboarded=TRUE, updated_at=CURRENT_TIMESTAMP, display_name='Conduit Demo' WHERE user_id = 'e9fc7e46-a8a5-4fd4-8ba7-af485013e6fa';

DELETE FROM public.workspaces WHERE user_id = 'e9fc7e46-a8a5-4fd4-8ba7-af485013e6fa';

INSERT INTO public.workspaces(id, user_id, is_home, name, default_context_length, default_model, default_prompt, default_temperature, description, embeddings_provider, include_profile_context, include_workspace_instructions, instructions)
VALUES(
    '0fa35765-d33f-4bc3-8421-6f0d6bb46a03',
    'e9fc7e46-a8a5-4fd4-8ba7-af485013e6fa',
    TRUE,
    'Home',
    4096,
    'deepseek-r1:8b',
    'You are a friendly, helpful AI assistant.',
    0.5,
    'My home workspace.',
    'ollama',
    TRUE,
    TRUE,
    ''
);

-- Start data for assistants
INSERT INTO assistants (user_id, name, description, model, image_path, sharing, context_length, include_profile_context, include_workspace_instructions, prompt, temperature, embeddings_provider) VALUES
    ('e9fc7e46-a8a5-4fd4-8ba7-af485013e6fa', 'Conduit Assistant', 'This is an Conduit Assistant assistant.', 'deepseek-r1:8b', '', 'private', 4000, TRUE, TRUE, 'You are Albert Einstein.', 0.5, 'ollama');

-- Get assistant id
DO $$
DECLARE
  assistant1_id UUID;
BEGIN
  SELECT id INTO assistant1_id FROM assistants WHERE name='Conduit Assistant';

  -- start data for assistant_workspaces
  INSERT INTO assistant_workspaces (user_id, assistant_id, workspace_id) VALUES
    ('e9fc7e46-a8a5-4fd4-8ba7-af485013e6fa', assistant1_id, '0fa35765-d33f-4bc3-8421-6f0d6bb46a03');
END;
$$;

-- Start data for collections
INSERT INTO collections (id, user_id, name, description, created_at, updated_at, sharing) VALUES
    ('17ebf136-b08d-443e-b0d0-ac45369ad31a', 'e9fc7e46-a8a5-4fd4-8ba7-af485013e6fa', 'Conduit Documents', 'This collection contains documents uploaded by Conduit', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'private');
INSERT INTO collection_workspaces (user_id, collection_id, workspace_id) VALUES
    ('e9fc7e46-a8a5-4fd4-8ba7-af485013e6fa', '17ebf136-b08d-443e-b0d0-ac45369ad31a', '0fa35765-d33f-4bc3-8421-6f0d6bb46a03');
