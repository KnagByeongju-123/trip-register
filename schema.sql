-- 출장등록 저장용 테이블 (개인용: 로그인 없이 사용)
-- Supabase 대시보드 > SQL Editor 에 붙여넣고 한 번 실행하세요. 다시 실행해도 데이터는 지워지지 않습니다.
-- (이미 만들어져 있으므로 지금 다시 실행할 필요는 없습니다)

create table if not exists public.trip_docs (
  id          uuid primary key default gen_random_uuid(),
  title       text not null default '',
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create index if not exists trip_docs_updated_at_idx on public.trip_docs (updated_at desc);

alter table public.trip_docs enable row level security;

drop policy if exists "trip_docs anon select" on public.trip_docs;
drop policy if exists "trip_docs anon insert" on public.trip_docs;
drop policy if exists "trip_docs anon update" on public.trip_docs;
drop policy if exists "trip_docs anon delete" on public.trip_docs;

create policy "trip_docs anon select" on public.trip_docs for select to anon using (true);
create policy "trip_docs anon insert" on public.trip_docs for insert to anon with check (true);
create policy "trip_docs anon update" on public.trip_docs for update to anon using (true) with check (true);
create policy "trip_docs anon delete" on public.trip_docs for delete to anon using (true);

-- 멤버 목록은 별도 테이블 없이 trip_docs 안의 '__members__' 행에 저장됩니다(앱 [설정] 탭에서 관리).
