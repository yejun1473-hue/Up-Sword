-- Enable Row Level Security on profiles table
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Policy to allow users to read their own profile
CREATE POLICY "사용자 본인의 프로필만 읽기"
ON public.profiles
FOR SELECT
USING (auth.uid() = id);

-- Policy to allow users to update their own profile
CREATE POLICY "사용자 본인의 프로필만 업데이트"
ON public.profiles
FOR UPDATE
USING (auth.uid() = id);

-- Policy to allow users to insert their own profile
CREATE POLICY "사용자 인증 시 프로필 자동 생성"
ON public.profiles
FOR INSERT
WITH CHECK (auth.uid() = id);

-- Policy for admin users (if you have an admin role)
-- Note: This is optional, uncomment if you need admin access
-- CREATE POLICY "관리자는 모든 프로필에 접근 가능"
-- ON public.profiles
-- FOR ALL
-- USING (auth.jwt() ->> 'user_metadata'->>'role' = 'admin');
